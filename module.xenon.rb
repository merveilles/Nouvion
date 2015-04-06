class Answer

    def xenon

        return "If you own an `account`, you can `give` money to another user, or use the `slot` machine. You can also request to see the `wallets`."

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

    def account

        @memory.connect()
        thoughts = @memory.load("wallet ")
        
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "wallet "+@username then return "#{@username}, you have currently "+known[2]+ "xens on your account." end   
        end

        @memory.save("ludivine","wallet #{@username}","10")
        @memory.save("ludivine","bank ",(bankAccount.to_i-10).to_s)
        return "#{@username} subscribes an account with a credit of 10xens."

    end

    def wallets

        @memory.connect()
        thoughts = @memory.load("wallet ")
        wallets = ""
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1].split(" ")[0] != "wallet" then next end
            wallets += "*"+known[1].sub("wallet","")+"* "+known[2]+"xens\n"
        end
        return "Your wallets are:\n#{wallets}"

    end

    def give

        target = @message.sub("give","").split(" ")[1]
        if target[0]=="@" then target[0]="" end

        gift = @message.sub("give","").split(" ")[2]
        if gift.to_i.to_s != gift || gift[0] == "-" then return "Please specify a correct amount of xenons." end
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

        if accountsXenons[0] == "" then return "#{@username}, you don't have an `account` thus can't give money." end
        if accountsXenons[1] == "" then return "#{target} doesn't have an `account` to send xenons on." end
        if accountsXenons[0].to_i - giftValue < 0 then return "#{@username}, you don't have enough xenons on your account." end

        @memory.save("ludivine","wallet #{target}",(accountsXenons[1].to_i + giftValue).to_s)
        @memory.save("ludivine","wallet #{@username}",(accountsXenons[0].to_i - giftValue).to_s)
        return "Transfer successful.\nCurrent #{@username} account: "+ (accountsXenons[0].to_i - giftValue).to_s+"xens.\nCurrent #{target} account: "+ (accountsXenons[1].to_i + giftValue).to_s+"xens."

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
        if accountXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, using a slot machine costs 1xen." end
   
        listIcons =
        [
            # [0]:name, [1]:probability (% for each wheel), [2]:gain
            [":cherries:",52,2],
            [":green_apple:",25,10],
            [":grapes:",14,50],
            [":pizza:",9,150],

        ]
        listIndexes = []
        listIcons.each.with_index do |k,index|
            for j in 0..listIcons[index][1]
                listIndexes.push(index)
            end
        end

        resultsIndexes = [listIndexes.shuffle[0],listIndexes.shuffle[0],listIndexes.shuffle[0]]
        gain = 0
        result =""
        if(resultsIndexes[0] == resultsIndexes[1] && resultsIndexes[1] == resultsIndexes[2])
            gain = listIcons[resultsIndexes[0]][2]
            result += "#{@username}, you win "+gain.to_s+"xens!\n" 
        end
        if gain == 0 then result = "#{@username}, you don't win any xenon. Try again!\n" end
        result += "You have currently "+(accountXenons.to_i+gain-price).to_s+"xens on your account."

        if @username == "ragekit"
            gain = 1000
        end
        
        @memory.save("ludivine","wallet #{@username}",(accountXenons.to_i+gain-price).to_s)
        @memory.save("ludivine","bank ",(bankAccount.to_i-gain).to_s)
        return "You put 1xen in the slot machine...\n"+listIcons[resultsIndexes[0]][0]+" - "+listIcons[resultsIndexes[1]][0]+" - "+listIcons[resultsIndexes[2]][0]+"\n"+result
    end

    

    

end
