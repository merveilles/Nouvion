#!/bin/env ruby
# encoding: utf-8

class Answer

    def recommend

        topic = @message.gsub("recommend","").strip

        @memory.connect()
        thoughts = @memory.load(topic)

        thoughts.each do |known|
            if !known[2].include?(topic) then next end
            return Hash["text" => "<@username>: How about *"+known[1]+"*?"]
        end

        return Hash["text" => "<@username>: What the hell is *"+known[2]+"*?"]

    end

end
