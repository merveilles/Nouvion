#!/bin/env ruby
# encoding: utf-8

class Answer
    def health
        @memory.connect
        thoughts = @memory.load("health #{@username}")

        health = thoughts[0][2].to_i

        if health < 1
            return "@#{@username}: You are _dead_."
        else
            return "@#{@username}: You currently have #{health} health."
        end
    end

    def all
        @memory.connect
        thoughts = @memory.load('health ')

        standings = ''
        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1].split(' ')[0] != 'health' then next end

            username = known[1].sub('health', '').strip
            health = known[2].to_i

            if health < 1
                standings += "*#{username}* _dead_\n"
            else
                standings += "*#{username}* #{health}hp\n"
            end

        end

        "Current health standings:\n#{standings}"
    end
end
