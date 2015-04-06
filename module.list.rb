#!/bin/env ruby
# encoding: utf-8

class Answer

    def list

        topic = @message.gsub("list", "").strip

        @memory.connect()
        thoughts = @memory.load(topic)
        thoughts.keep_if {|x| x[2].include?(topic) }

        if thoughts.size() > 0 then
            return "I know #{thoughts.size()} kind#{thoughts.size() == 1 ? "" : "s"} of *#{topic}* : *#{thoughts.map { |x| x[1] }.join("*, *")}*."
        end

        return "I don't know any *#{topic}*."

    end

end
