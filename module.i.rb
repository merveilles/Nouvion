#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def i

        @memory.connect()
        @memory.save("ludivine","last query "+@username,@message.downcase)

        response = @message.downcase
        response = " "+response+" "
        response = response.gsub(" you "," me ").strip
        response = " "+response+" "
        response = response.sub("i am","are you")
        response = " "+response+" "
        response = response.sub(" i "," do you ").strip

        return "Why "+response+"?"

    end

end