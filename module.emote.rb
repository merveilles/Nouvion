#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def emote

        return smile

    end

    #show us your true face, ludivine
    def smile

        oper = @message.split(" ")[0]
        val1 = @message.split(" ")[1].to_i
        val2 = @message.split(" ")[2].to_i

        eyes = ["O","o","^","*" ]
        mouths = ["_","__","." ]

        symmetry = rand(1) > 0

        lefteye = eyes.shuffle[0]
        righteye = lefteye
        if( !symmetry )
            righteye = eyes.shuffle[0]
        end

        text = lefteye + mouths.shuffle[0] + righteye

        return Hash["text" => text ]

    end

    def flip
        message = @message.sub("emote flip", "").strip

        return Hash["text" => "(╯°□°）╯︵ ┻━┻" + if message.length > 0 then " *#{message}*" else "" end]
    end

    def shrug

        message = @message.sub("emote shrug", "").strip

        return Hash["text" => if message.length > 0 then " *#{message}* " else "" end + "¯\\_(ツ)_/¯"]

    end

end
