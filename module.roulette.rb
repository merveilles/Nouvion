# encoding: utf-8

require "api"

class Answer
    def roulette
        return API::Roulette.usage
    end

    def load
        roulette = API::Roulette.new(@username, @memory)

        return roulette.load_revolver
    end

    def spin
        roulette = API::Roulette.new(@username, @memory)

        return roulette.spin_cylinder
    end

    def pull
        roulette = API::Roulette.new(@username, @memory)

        return roulette.pull_trigger
    end
end
