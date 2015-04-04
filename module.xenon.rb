class Answer

    def xenon

        return "If you own an 'account', you can `give` money to another user - or request to see the `wallets`."

    end

    def account

        @memory.connect()
        thoughts = @memory.load("wallet ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] == "wallet "+@username then return "#{@username}, you have currently "+known[2]+ " xenons on your account." end
        end

        @memory.save("ludivine","wallet #{@username}","10")
        return "#{@username} subscribes an account with a credit of 10 xenons."

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

        gift = @message.sub("give","").split(" ")[2]
        if gift.to_i.to_s != gift then return "Please specify a correct amount of xenons." end
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

        if accountsXenons[0] == "" then return "#{@username}, you don't have an account thus can't give money." end
        if accountsXenons[1] == "" then return "#{target} doesn't have an account to send money on." end
        if accountsXenons[0].to_i - giftValue < 0 then return "#{@username}, you don't have enough xenons on your account." end

        @memory.save("ludivine","wallet #{target}",(accountsXenons[1].to_i + giftValue).to_s)
        @memory.save("ludivine","wallet #{@username}",(accountsXenons[0].to_i - giftValue).to_s)
        return "Transfert successful.\nCurrent #{@username} account: "+ (accountsXenons[0].to_i - giftValue).to_s+" xenons.\nCurrent #{target} account: "+ (accountsXenons[1].to_i + giftValue).to_s+" xenons."

    end

end
