#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def i

        response = @message.downcase
        response = " "+response+" "
        response = response.gsub(" you "," me ").strip
        response = " "+response+" "
        response = response.sub("i am","are you")
        response = " "+response+" "
        response = response.sub(" i "," do you ").strip
        return Hash["text" => "Why "+response+"?"]

    end

end
