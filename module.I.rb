#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def i

        response = @message.sub(@message.split(" ")[0],"").strip
        response = response.sub("am","are you")
        return Hash["text" => "Why "+response+"?"]

    end

    def hate

    	if(@message.split(" ")[2] == "you") then return Hash["text" => "I... I'm so sorry Senpaï"] end
    	return Hash["text" => "What do you hate ?"]

    end

    def feel

    	rd = rand(10)
    	if rd == 0 then return Hash["text" => "Ok"] end
    	return Hash["text" => "I'm so sorry you feel "+@message.sub("i feel","").strip+"."]

    end

end