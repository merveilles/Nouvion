require 'api'

class Answer
    def balance
        account = API::Xenon.new(@username)

        balance = account.balance

        return "<@#{@username}>: You have #{balance}:xen: in your account."
    end

    def give
        message = @message.split(' ')

        target = message[2].gsub(/[@<>]/, '')
        amount = message[3]

        source_account = API::Xenon.new(@username)

        result = source_account.transfer(target, amount)

        if result == true
            return "<@#{@username}>: You have given <@#{target}> #{amount}:xen: from your account."
        else
            return "<@#{@username}>: #{result}"
        end
    end
end
