#!/bin/env ruby
# encoding: utf-8

require 'api'

class Answer
    def roulette
        return API::Roulette.usage
    end

    def load
        chamber = ''

        @memory.connect
        thoughts = @memory.load('roulette chamber')
        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1] != 'roulette chamber' then next end
            chamber = known[2]
        end

        if chamber.to_i > 0 then return 'There is already a bullet in the revolver.' end
        @memory.save('ludivine', 'roulette chamber', '100000'.split('').shuffle.join)
        'You put a bullet in the revolver. :japanese_ogre:'
    end

    def spin
        chamber = ''

        @memory.connect
        thoughts = @memory.load('roulette chamber')
        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1] != 'roulette chamber' then next end
            chamber = known[2]
        end

        @memory.save('ludivine', 'roulette chamber', chamber.split('').shuffle.join)
        "#{@username} spins the cylinder. :return:"
    end

    def bullets
        chamber = ''

        @memory.connect
        thoughts = @memory.load('roulette chamber')
        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1] != 'roulette chamber' then next end
            chamber = known[2]
        end

        if chamber.index('1') > -1
            return 'The bullet is in the *chamber #' + chamber.index('1').to_s + '*.'
        else
            return "There are no bullets in the gun's chamber."
        end
    end

    def pull
        chamber = ''

        @memory.connect
        thoughts = @memory.load('roulette chamber')
        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1] != 'roulette chamber' then next end
            chamber = known[2]
        end

        chamberValue = chamber[0, 1]

        # Update Chamber

        chamber[0] = ''
        chamber = chamber + '0'
        @memory.save('ludivine', 'roulette chamber', chamber)

        if chamberValue == '1'
            @memory.save('ludivine', "health #{@username}", 0.to_s)
            return "You pull the trigger, the gun goes.. *POW*! :finnadie::collision::gun:\nYou shot yourself in the face and died.."
        end

        if chamber.to_i == 0
            return "You pull the trigger, the gun goes.. *click*! :relaxed:\nThe gun is empty, you should `load` it."
        end

        "You pull the trigger, the gun goes.. *click*! :godmode:\nYou survived."
    end
end
