#!/bin/env ruby
# encoding: utf-8

require 'api'

class Answer
    def goat
        'What about goats?'
    end

    def tower
        tower = API::Goat::Tower.new(@username)

        return tower.climb
    end

    def thrower
        thrower = API::Goat::Thrower.new(@username)

        return thrower.throw
    end
end
