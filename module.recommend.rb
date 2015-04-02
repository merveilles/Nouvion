#!/bin/env ruby
# encoding: utf-8

class Answer

    def recommend

        topic = @message.gsub("recommend","").strip

        @memory.connect()
        thoughts = @memory.load(topic).shuffle

        thoughts.each do |known|
            if !known[2].include?(topic) then next end
            return Hash["text" => "How about *"+known[1]+"*, <@#{@username}>?"]
        end

        return Hash["text" => "<@#{@username}>: What is *"+topic+"*?"]

    end

end
