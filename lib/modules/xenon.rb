require 'api/wallet'

class Answer
    def transfer
        samount, user = @message.split(' ')
        amount = samount.to_i
        you = Wallet.new(@username, @memory)
        if amount > you.contents
            return "you don't have that much xenon."
        else
            them = Wallet.new(user, @memory)
            you.transfer(amount, them)
            return "#{@username} reduced to #{you.contents}XEN, #{user} increased to #{them.contents}XEN."
        end
    end

    def handout
        amount = @message.split(' ')[0].to_i
        if amount >= 0
            return "no."
        else
            you = Wallet.new(@username, @memory)
            bank = Wallet.the_house(@memory)
            amountToTransfer = -amount
            you.transfer bank, [amountToTransfer, you.contents].min
            return "No problem."
        end
    end

    def balance
        return "you have #{Wallet.new(@username, @memory).contents}XEN."
    end

    def help
        return "
transfer <amount of xen to transfer> <user to transfer to> : hand money to someone
handout <amount of xen you want from the bank> : get free money
balance : tells how much xenon you have
"
    end
end
