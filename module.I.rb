#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message
    def hate
    	args = @message.split(" ");
    	if(args[0] == "you")
    		return Hash["text" => "I... I'm so sorry Senpaï"]
    	end

    	return Hash["text" => "What do you hate ?"]
    end

    def feel
    	args = @message;
    	rd = rand(10)
    	if rd == 0
    		return Hash["text" => "Ok"]
    	end
    	
    	return Hash["text" => "I'm so sorry you feel #{args}"]
    end
end