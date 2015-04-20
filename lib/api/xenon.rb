module API
    class Xenon
        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? API::MemoryXenon.new : memory

            unless @memory.exists(@username)
                @memory.add(@username)
            end
        end

        def balance()
            return @memory.load(@username)[0][2]
        end

        def transfer(username, amount)
            amount = amount.to_i

            puts username

            if balance < amount
                return "You do not have that much Xenon!"
            end

            if USERS[username] == nil
                target = USERS.select { |k, v| v == username }.first[0]
            else
                target = username
            end

            target_account = API::Xenon.new(target)

            subtract(amount)

            target_account.add(amount)

            return true
        end

        def add(amount)
            new_balance = balance + amount

            @memory.update(@username, new_balance)
        end

        def subtract(amount)
            new_balance = balance - amount

            @memory.update(@username, new_balance)
        end
    end
end
