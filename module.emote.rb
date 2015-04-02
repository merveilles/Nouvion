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
        return Hash["text" => "(╯°□°）╯︵ ┻━┻ *"+@message.sub("emote flip","").capitalize+"*"]
    end

end
