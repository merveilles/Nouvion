# encoding: utf-8

class Answer
    def initialize(module_name, method_name, username, message, channel, memory = nil)
        @module_name = module_name
        @method_name = method_name
        @username    = username
        @message     = message
        @channel     = channel
        @memory      = if memory == nil then Memory.new else memory end
    end

    def includeModule name

        require "modules/module.#{name}.rb"

    end

    def unknownModule
        # return "Huh? #{@username}, what do you want me to do?"
    end

    def unknownMethod
        # return "Huh? Sorry #{@username}, *#{@moduleName}* does not have a method called *#{@methodName}*."
    end

    def hey

        return "hey #{@username}."

    end

    def hi

        return "hi #{@username}!"

    end

    def sorry

        return "Don't worry about it *#{@username}*."

    end

    def where

        return "You are in *#{@channel}*."

    end

    def say

        if @username == "slackbot" then return "Stop messing with me..." end

        cleanMessage = @message.sub("say ", "").strip()

        if cleanMessage.include? "in channel"
            parts = cleanMessage.split("in channel")
            channel = parts[1].strip()
            cleanMessage = parts[0].strip()

            return cleanMessage, "channel" => "##{channel}"
        else
            return cleanMessage
        end

        return @message.sub("say ","")

    end

    def rules

        rules = [
            "Rule #1: You must find yourself a monochromatic avatar.",
            "Rule #2: I, *Ludivine*, am above the law."
        ]

        return rules.join("\n")

    end

    def forget

        return "Ludivine never forgets."

    end

    def cya

        return "Bye bye "+@username+"!"

    end

    def announce

        sayInChannel("#the-lobby","*"+@username+"* wants your attention in <#"+@channel+">.")
    end

end
