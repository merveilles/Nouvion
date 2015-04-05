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
    
    attr_reader :flippingEmojis
    attr_reader :unflippingEmojis

    def flip
        
        @memory.connect()
        flipStates = @memory.load("table flipped") 

        flipState = "no"
        flipStates.each do |state|
            if state[0] != "ludivine" then next end
            if state[1] != "table flipped" then next end
            flipState = state[2]
        end
        
        @flippingEmojis = ["(ﾉ °□°)ﾉ︵ ┻─┻" , "(ノ ゜Д゜)ノ ︵ ┻━┻" , "(ﾉಥ益ಥ）ﾉ﻿ ┻━┻" , "(╯'□')╯︵ ┻━┻"]
        @unflippingEmojis = ["┬─┬﻿ ノ(゜-゜ノ)"]
        if flipState == "yes" 
          emoji = @unflippingEmojis.shuffle[0]
          flipState = "no"
        else
          emoji = @flippingEmojis.shuffle[0]
          flipState = "yes"
        end
        
        @memory.save("ludivine", "table flipped", flipState)
        
        message = @message.sub("emote flip", "").strip

        return (emoji + if message.length > 0 then " *#{message}*" else "" end)
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