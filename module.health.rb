#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def health

        @memory.connect()
        thoughts = @memory.load("health #{@username}")

        health = thoughts[2].to_i

        if health < 1
            return "@#{@username}: You are _dead_."
        else
            return "@#{@username}: You currently have #{health}hp."
        end

    end

    def all

        @memory.connect()
        thoughts = @memory.load("health ")

        standings = ""
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1].split(" ")[0] != "health" then next end
            if known[2].to_i < 1
                standings += "*" + known[1].sub("health", "") + " * _dead_\n"
            else
                standings += "*" + known[1].sub("health", "") + "* " + known[2] + "hp\n"
            end

        end

        return "Current health standings:\n#{standings}"

    end

end
