#!/bin/env ruby
# encoding: utf-8

class Answer
    # Available: moduleName,methodName,username,message

    def dice
        diceValue = @message.split(' ')[3].to_i

        if diceValue > 100_000_000_000
            return 'Mhm, grow up.'
        end

        if diceValue > 0
            roll = rand(diceValue) + 1

            return "Rolling a #{diceValue} sided dice, the result is #{roll}."
        end

        roll = rand(6) + 1

        "Rolling a 6 sided dice, the result is #{roll}."
    end

    def barrel
        '*does a barrel roll*'
    end

    def cigarette
        "Sorry, I don't smoke."
    end

    def katamari
        'na na   na na na na na na na'
    end
end
