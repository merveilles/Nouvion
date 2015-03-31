#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def emote

        responses = ["My emotion module is tender.", "I feel electric" ]
        return Hash["text" => responses.shuffle[0] ]

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

end