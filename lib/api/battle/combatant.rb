# encoding: utf-8

module API::Battle
    include API::Memory

    class Combatant
        def initialize(username)
            @username = username
        end

        def save
            API::Memory.save
        end
    end
end
