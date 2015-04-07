class Answer

    def xenon

        return "If you own an `account`, you can `give` :xen: to another user, use the `slot` machine or play the `jackpot`. You can also request to see `all` the xenons of Merveilles."

    end

    def bankAccount
        @memory.connect()
        thoughts = @memory.load("bank ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "bank " then return known[2] end
        end
        return "1000"
    end

    def jackpotAccount
        @memory.connect()
        thoughts = @memory.load("jackpot ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "jackpot " then return known[2] end
        end
        return "10"
    end

    def all

        @memory.connect()
        thoughts = @memory.load("wallet ")
        xenonDistribution = ""
        xenonTotal = 0
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1].split(" ")[0] != "wallet" then next end
            xenonDistribution += "*"+known[1].sub("wallet","")+"* owns "+known[2]+":xen:.\n"
            xenonTotal += known[2].to_i
        end
        xenonDistribution += "\nThere are currently "+bankAccount+":xen: in the bank.\n"
        xenonDistribution += "\nThere are currently "+jackpotAccount+":xen: in the jackpot.\n"

        xenonTotal += bankAccount.to_i
        xenonTotal += jackpotAccount.to_i
        xenonDistribution +="\nTotal amount in Merveilles: "+xenonTotal.to_s+":xen:."

        return xenonDistribution
    end

    def account

        @memory.connect()
        thoughts = @memory.load("wallet ")
        
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "wallet "+@username then return "#{@username}, you have currently "+known[2]+ ":xen: on your account." end   
        end

        @memory.save("ludivine","wallet #{@username}","10")
        @memory.save("ludivine","bank ",(bankAccount.to_i-10).to_s)
        return "#{@username} subscribes an account with a credit of 10:xen:."

    end

    def give

        target = @message.sub("give","").split(" ")[1]
        if target[0]=="@" then target[0]="" end

        gift = @message.sub("give","").split(" ")[2]
        if gift.to_i.to_s != gift || gift[0] == "-" then return "Please specify a correct amount of :xen:." end
        giftValue = gift.to_i.abs

        accountsXenons = ["",""] # accountsXenons[0] for sender xenons, accountsXenons[1] for receiver xenons
        @memory.connect()
        thoughts = @memory.load("wallet ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "wallet "+@username then accountsXenons[0] = known[2] end
            if known[1] == "wallet "+target then accountsXenons[1] = known[2] end
            if accountsXenons[0] !="" && accountsXenons[1] !="" then break end
        end

        if accountsXenons[0] == "" then return "#{@username}, you don't have an `account` thus can't give xenons." end
        if accountsXenons[1] == "" then return "#{target} doesn't have an `account` to send xenons on." end
        if accountsXenons[0].to_i - giftValue < 0 then return "#{@username}, you don't have enough xenons on your account." end

        @memory.save("ludivine","wallet #{target}",(accountsXenons[1].to_i + giftValue).to_s)
        @memory.save("ludivine","wallet #{@username}",(accountsXenons[0].to_i - giftValue).to_s)
        return "#{@username} gives "+gift+":xen: to "+target+".\nCurrent #{@username} account: "+ (accountsXenons[0].to_i - giftValue).to_s+":xen:.\nCurrent #{target} account: "+ (accountsXenons[1].to_i + giftValue).to_s+":xen:."

    end

    def slot
        price = 1

        accountXenons = ""
        @memory.connect()
        thoughts = @memory.load("wallet ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "wallet "+@username
                accountXenons = known[2]
                break
            end
        end
        if accountXenons == "" then return "#{@username}, you don't have an `account` thus can't play slot machine." end
        if accountXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, using a slot machine costs 1:xen:." end
   
        listIcons =
        [
            # [0]:name, [1]:probability (% for each wheel), [2]:gain
            [":fishbone:",52,2],
            [":cherry:",25,10],
            [":lucky7:",14,50],
            [":blackpizza:",9,150],
        ]
        listIndexes = []
        listIcons.each.with_index do |k,index|
            for j in 0..listIcons[index][1] do listIndexes.push(index) end
        end

        resultsIndexes = [listIndexes.shuffle[0],listIndexes.shuffle[0],listIndexes.shuffle[0]]
        gain = 0
        result ="#{@username}, you don't win any xenon. Try again!\n"

        if(resultsIndexes[0] == resultsIndexes[1] && resultsIndexes[1] == resultsIndexes[2])
            gain = listIcons[resultsIndexes[0]][2]
            result = "#{@username}, you win "+gain.to_s+"xens!\n" 
        end
       
        result += "You have currently "+(accountXenons.to_i+gain-price).to_s+":xen: on your account."

        @memory.save("ludivine","wallet #{@username}",(accountXenons.to_i+gain-price).to_s)
        @memory.save("ludivine","bank ",(bankAccount.to_i-gain).to_s)
        return "You put "+price.to_s+":xen: in the slot machine...\n"+listIcons[resultsIndexes[0]][0]+" - "+listIcons[resultsIndexes[1]][0]+" - "+listIcons[resultsIndexes[2]][0]+"\n"+result
    end

    def jackpot
        price = 1

        accountXenons = ""
        @memory.connect()
        thoughts = @memory.load("wallet ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "wallet "+@username
                accountXenons = known[2]
                break
            end
        end
        if accountXenons == "" then return "#{@username}, you don't have an `account` thus can't play slot machine." end
        if accountXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, using a slot machine costs 1:xen:." end

        gain = 0
        result = "#{@username}, you don't win the jackpot. Try again!\n"
        accountUserValue = (accountXenons.to_i-price).to_s

        if rand(300)<1
            gain = jackpotAccount.to_i
            result = "#{@username}, JACKPOT! You win "+gain.to_s+":xen:.\n"
            @memory.save("ludivine","wallet #{@username}",(accountXenons.to_i+gain).to_s)
            @memory.save("ludivine","jackpot ","10")
            @memory.save("ludivine","bank ",(bankAccount.to_i-10).to_s)
            accountUserValue = (accountXenons.to_i+gain).to_s
        else
            @memory.save("ludivine","wallet #{@username}",(accountXenons.to_i-price).to_s)
            @memory.save("ludivine","jackpot ",(jackpotAccount.to_i+price).to_s)
        end

        return "You put "+price.to_s+":xen: in the jackpot totem...\n"+result+"The jackpot value is now "+(jackpotAccount.to_i).to_s+":xen:.\nYou have currently "+accountUserValue+":xen: on your account."
    end
end
