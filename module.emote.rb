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

        return text

    end

    def flip
        
        @memory.connect()
        flipped = @memory.load("flipped") 
        
        if flipped == "yes" then 
          emoticon = "┬─┬ ノ(°-°ノ)"
          flipped = "no"
        else
          emoticon = "(╯°□°）╯︵ ┻━┻"
          flipped = "yes"
        end
        
        @memory.save("ludivine", "flipped", flipped)
        
        message = @message.sub("emote flip", "").strip

        return (emoticon + if message.length > 0 then " *#{message}*" else "" end)
    end

    def shrug

        message = @message.sub("emote shrug", "").strip

        return (if message.length > 0 then "*#{message}* " else "" end + "¯\\_(ツ)_/¯")

    end

    def donger

        message = @message.sub("emote donger", "").strip

        message = if message.length > 0 then message else "raise your dongers" end

        return "ヽ༼ຈل͜ຈ༽ﾉ #{message} ヽ༼ຈل͜ຈ༽ﾉ"

    end

    def molly

        message = @message.sub("emote molly", "").strip

        message = if message.length > 0 then message.upcase else "MOLLY" end

        return "༼ つ ◕_◕ ༽つ #{message} ༼ つ ◕_◕ ༽つ"

    end

end
