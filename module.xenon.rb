class Answer

    def xenon

        return "If you own an `account`, you can `give` xenons to another user, use the `slot` machine or play the `jackpot`. You can also request to see `all` the xenons of Merveilles."

    end

    def getBankAccount
        return MemoryObject.new("", @memory).load_from_memory("bank","3000")
    end

    def getJackpotAccount
        return MemoryObject.new("", @memory).load_from_memory("jackpot","10")
    end

    def all

        xenonDistribution = ""
        xenonTotal = 0

        wallets = getAllMemoriesValuesOfType("wallet")
        wallets.each do |wallet|
            xenonDistribution += "*"+wallet[0]+"* owns "+wallet[1]+":xen:.\n"
            xenonTotal += wallet[1].to_i
        end

        xenonDistribution += "\nThere are currently "+getBankAccount+":xen: in the bank.\n"
        xenonDistribution += "\nThere are currently "+getJackpotAccount+":xen: in the jackpot.\n"
        xenonTotal += getBankAccount.to_i
        xenonTotal += getJackpotAccount.to_i
        xenonDistribution +="\nTotal amount in Merveilles: "+xenonTotal.to_s+":xen:."
        return xenonDistribution

    end

    def account

        userAccount = MemoryObject.new(@username, @memory) 
        valueOnAccount = userAccount.load_from_memory("wallet","")
        if valueOnAccount != "" then return "#{@username}, you have currently "+valueOnAccount+ ":xen: on your account." end   
        
        bankAccount = MemoryObject.new("", @memory)
        bankAccount.save_to_memory("bank", (bankAccount.load_from_memory("bank","3000").to_i-10).to_s)
        userAccount.save_to_memory("wallet","10")

        return "#{@username} subscribes an account with a credit of 10:xen:."

    end

    def give

        gift = @message.sub("give","").split(" ")[2]
        if gift.to_i.to_s != gift || gift[0] == "-" then return "Please specify a correct amount of :xen:." end
        giftValue = gift.to_i.abs

        target = @message.sub("give","").split(" ")[1]
        if target[0]=="@" then target[0]="" end

        accountSender = MemoryObject.new(@username, @memory)    
        accountReceiver = MemoryObject.new(@username, @memory)
        accountsXenons = [accountSender.load_from_memory("wallet",""),accountReceiver.load_from_memory("wallet","")] # accountsXenons[0] for sender xenons, accountsXenons[1] for receiver xenons

        if accountsXenons[0] == "" then return "#{@username}, you don't have an `account` thus can't give xenons." end
        if accountsXenons[1] == "" then return "#{target} doesn't have an `account` to send xenons on." end
        if accountsXenons[0].to_i - giftValue < 0 then return "#{@username}, you don't have enough xenons on your account." end

        accountSender.save_to_memory("wallet", (accountsXenons[0].to_i+giftValue).to_s)   
        accountReceiver.save_to_memory("wallet", (accountsXenons[1].to_i-giftValue).to_s) 

        return "#{@username} gives "+gift+":xen: to "+target+".\nCurrent #{@username} account: "+ (accountsXenons[0].to_i - giftValue).to_s+":xen:.\nCurrent #{target} account: "+ (accountsXenons[1].to_i + giftValue).to_s+":xen:."

    end

    def slot
        price = 1

        userAccount = MemoryObject.new(@username,@memory)
        currentXenons = userAccount.load_from_memory("wallet", "")
        if currentXenons == "" then return "#{@username}, you don't have an `account` thus can't play slot machine." end
        if currentXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, using a slot machine costs 1:xen:." end
   
        # [[0]:name, [1]:probability (% for each wheel), [2]:gain]
        listIcons =[[":fishbone:",52,2],[":cherry:",25,10],[":lucky7:",14,50],[":blackpizza:",9,150]]
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
       
        result += "You have currently "+(currentXenons.to_i+gain-price).to_s+":xen: on your account."

        userAccount.save_to_memory("wallet",(currentXenons.to_i+gain-price).to_s)
        MemoryObject.new("", @memory).save_to_memory("bank",(getBankAccount.to_i-gain).to_s)
        return "You put "+price.to_s+":xen: in the slot machine...\n"+listIcons[resultsIndexes[0]][0]+" - "+listIcons[resultsIndexes[1]][0]+" - "+listIcons[resultsIndexes[2]][0]+"\n"+result
    end

    def jackpot
        price = 1

        userAccount = MemoryObject.new(@username,@memory)
        currentXenons = userAccount.load_from_memory("wallet", "")
        if currentXenons == "" then return "#{@username}, you don't have an `account` thus can't play jackpot." end
        if currentXenons.to_i - price < 0 then return "#{@username}, you don't have enough xenons on your account, playing jackpot costs 1:xen:." end

        gain = 0
        result = "#{@username}, you don't win the jackpot. Try again!\n"
       
        if rand(300)<1
            gain = getJackpotAccount.to_i
            currentXenons = (currentXenons.to_i+gain).to_s
            result = "#{@username}, JACKPOT! You win "+gain.to_s+":xen:.\n"
            MemoryObject.new("", @memory).save_to_memory("jackpot","10")
            MemoryObject.new("", @memory).save_to_memory("bank",(getBankAccount.to_i-10).to_s)
        else
            currentXenons = (currentXenons.to_i-price).to_s
            MemoryObject.new("", @memory).save_to_memory("jackpot",(getJackpotAccount.to_i+price).to_s)
        end
        userAccount.save_to_memory("wallet",currentXenons)

        return "You put "+price.to_s+":xen: in the jackpot totem...\n"+result+"The jackpot value is now "+(getJackpotAccount.to_i).to_s+":xen:.\nYou have currently "+currentXenons+":xen: on your account."
    end

    

end

class MemoryObject
    
    attr_reader :name
    
    def initialize(name, memory)
        @name = name
        @memory = memory
        
        @memory.connect()
    end
    
    def load_from_memory(attribute, default_value = nil)
        thoughts = @memory.load(attribute + " ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end #ludivine hosts all health
            if known[1] != "#{attribute} #{@name}" then next end

            return known[2]
        end
        
        @memory.save("ludivine", "#{@name} #{@attribute}", default_value.to_s) # add missing values to users that get instantiated as combatants
        return default_value.to_s
    end

    def save_to_memory(attribute, value)
        @memory.save("ludivine","#{attribute} #{@name}",value.to_s)
    end

end


def getAllMemoriesOfType(attribute)
    listMemories= []
    @memory.connect
    thoughts = @memory.load("#{attribute}" + " ")
    thoughts.each do |known|
        if known[0] != "ludivine" then next end
        if known[1].split(" ")[0] != "#{attribute}" then next end
        listMemories.push(MemoryObject.new(known[1].split(" ")[1],@memory))
    end
    return(listMemories)
end

def getAllMemoriesValuesOfType(attribute)
    listValues= []
    @memory.connect
    thoughts = @memory.load("#{attribute}" + " ")
    thoughts.each do |known|
        if known[0] != "ludivine" then next end
        if known[1].split(" ")[0] != "#{attribute}" then next end
        listValues.push([known[1].split(" ")[1],known[2].to_s])
    end
    return(listValues)
end

