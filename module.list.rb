#!/bin/env ruby
# encoding: utf-8

class Answer

    def list

        topic = @message.gsub("list", "").strip

        @memory.connect()
        thoughts = @memory.load(topic)
        matches = thoughts.select {|x| x[2].include?(topic) }

        if matches.size() > 0 then
            return "I know #{matches.size()} kind#{matches.size() == 1 ? "" : "s"} of *#{topic}* : *#{matches.map { |x| x[1] }.join("*, *")}*."
        end

        return "I don't know any *#{topic}*."

    end

end
