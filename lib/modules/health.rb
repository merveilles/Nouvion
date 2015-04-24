require 'api'

class Answer
    def health
        health = API::Health.new(@username)

        current_health = health.check

        if current_health < 1
            return "<@#{@username}>: You are _dead_."
        else
            return "<@#{@username}>: You currently have #{current_health} health."
        end
    end

    def all
        health = API::Health.new(@username)

        standings = ""

        health.list.each do |username, hp|
            if hp < 1
                standings += "*#{USERS[username]}* _dead_\n"
            else
                standings += "*#{USERS[username]}* #{hp}hp\n"
            end
        end

        "Current health standings:\n#{standings}"
    end
end
