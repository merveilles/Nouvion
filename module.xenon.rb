require_relative 'utils.memory'

class Answer
    def xenon
        'If you own an `account`, you can `give` xenons to another user, use the `slot` machine or play the `jackpot`. You can also request to see `all` the xenons of Merveilles.'
    end

    def getBankAccount
        @memory.loadOrCreate('ludivine', 'bank', '3000').value
    end

    def getJackpotAccount
        @memory.loadOrCreate('ludivine', 'jackpot', '10').value
    end

    def all
        xenonDistribution = ''
        xenonTotal = 0

        wallets = @memory.loadAllAttributes('wallet')
        wallets.each do |wallet|
            xenonDistribution += '*' + wallet.key + '* owns ' + wallet.value + ":xen:.\n"
            xenonTotal += wallet[1].to_i
        end

        xenonDistribution += "\nThere are currently " + getBankAccount + ":xen: in the bank.\n"
        xenonDistribution += "\nThere are currently " + getJackpotAccount + ":xen: in the jackpot.\n"
        xenonTotal += getBankAccount.to_i
        xenonTotal += getJackpotAccount.to_i
        xenonDistribution += "\nTotal amount in Merveilles: " + xenonTotal.to_s + ':xen:.'
        xenonDistribution
    end

    def account
        userWallet = @memory.loadAttribute(@username, 'wallet')
        if userWallet.size() != 0 then return "#{@username}, you have currently " + userWallet[0].value + ':xen: on your account.' end

        @memory.save('ludivine', 'bank', (getBankAccount.to_i - 10).to_s)
        @memory.saveAttribute(@username, 'wallet', '10')

        "#{@username} subscribes an account with a credit of 10:xen:."
    end

    def give
        gift = @message.sub('give', '').split(' ')[2]
        if gift.to_i.to_s != gift || gift[0] == '-' then return 'Please specify a correct amount of :xen:.' end
        giftValue = gift.to_i.abs

        target = @message.sub('give', '').split(' ')[1]
        if target[0] == '@' then target[0] = '' end

        # accountsXenons[0] for sender xenons, accountsXenons[1] for receiver xenons
        accounts = [@memory.loadAttributeValue(@username, 'wallet'), @memory.loadAttributeValue(target, 'wallet')] 

        if accountsXenons[0] == nil then return "#{@username}, you don't have an `account` thus can't give xenons." end
        if accountsXenons[1] == nil then return "#{target} doesn't have an `account` to send xenons on." end
        if accountsXenons[0].to_i - giftValue < 0 then return "#{@username}, you don't have enough xenons on your account." end

        @memory.saveAttribute(@username, 'wallet', (accountsXenons[0].to_i - giftValue).to_s)
        @memory.saveAttribute(target, 'wallet', (accountsXenons[1].to_i + giftValue).to_s)

        "#{@username} gives " + gift + ':xen: to ' + target + ".\nCurrent #{@username} account: " + (accountsXenons[0].to_i - giftValue).to_s + ":xen:.\nCurrent #{target} account: " + (accountsXenons[1].to_i + giftValue).to_s + ':xen:.'
    end

    def slot
        price = 1

        currentXenons = @memory.loadAttributeValue(@username, 'wallet')
        if currentXenons == nil then return "#{@username}, you don't have an `account` thus can't play slot machine." end
        if currentXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, using a slot machine costs 1:xen:." end

        # [[0]:name, [1]:probability (% for each wheel), [2]:gain]
        listIcons = [[':fishbone:', 52, 2], [':cherry:', 25, 10], [':lucky7:', 14, 50], [':blackpizza:', 9, 150]]
        listIndexes = []
        listIcons.each.with_index do |_k, index|
            for j in 0..listIcons[index][1] do listIndexes.push(index) end
        end

        resultsIndexes = [listIndexes.shuffle[0], listIndexes.shuffle[0], listIndexes.shuffle[0]]
        gain = 0
        result = "#{@username}, you don't win any xenon. Try again!\n"

        if resultsIndexes[0] == resultsIndexes[1] && resultsIndexes[1] == resultsIndexes[2]
            gain = listIcons[resultsIndexes[0]][2]
            result = "#{@username}, you win " + gain.to_s + "xens!\n"
        end

        result += 'You have currently ' + (currentXenons.to_i + gain - price).to_s + ':xen: on your account.'

        @memory.saveAttribute(@username, 'wallet', (currentXenons.to_i + gain - price).to_s)
        @memory.save('ludivine', 'bank', (getBankAccount.to_i - gain).to_s)
        'You put ' + price.to_s + ":xen: in the slot machine...\n" + listIcons[resultsIndexes[0]][0] + ' - ' + listIcons[resultsIndexes[1]][0] + ' - ' + listIcons[resultsIndexes[2]][0] + "\n" + result
    end

    def jackpot
        price = 1

        currentXenons = @memory.loadAttributeValue(@username, 'wallet')
        if currentXenons == '' then return "#{@username}, you don't have an `account` thus can't play jackpot." end
        if currentXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, playing jackpot costs 1:xen:." end

        gain = 0
        result = "#{@username}, you don't win the jackpot. Try again!\n"

        if rand(300) < 1
            gain = getJackpotAccount.to_i
            currentXenons = (currentXenons.to_i + gain).to_s
            result = "#{@username}, JACKPOT! You win " + gain.to_s + ":xen:.\n"
            @memory.save('ludivine', 'jackpot', '10')
            @memory.save('ludivine', 'bank', (getBankAccount.to_i - 10).to_s)
        else
            currentXenons = (currentXenons.to_i - price).to_s
            @memory.save('ludivine', 'jackpot', (getJackpotAccount.to_i + price).to_s)
        end
         @memory.saveAttribute(@username, 'wallet', currentXenons)

        'You put ' + price.to_s + ":xen: in the jackpot totem...\n" + result + 'The jackpot value is now ' + (getJackpotAccount.to_i).to_s + ":xen:.\nYou have currently " + currentXenons + ':xen: on your account.'
    end
end
