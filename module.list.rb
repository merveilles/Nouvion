#!/bin/env ruby
# encoding: utf-8

class Answer

    def list

        topic = @message.gsub("list", "").strip
        if topic == "" then
            return "List does a reverse query on my memory. (e.g. _ludivine list single malt_)"
        end

        @memory.connect()
        thoughts = @memory.load(topic)
        matches = thoughts.select {|x| x[2].include?(topic) }

        if matches.size() > 0 then
            return "I know #{matches.size()} kind#{matches.size() == 1 ? "" : "s"} of *#{topic}* : _#{matches.map { |x| x[1] }.join("_, _")}_."
        end

        return "I don't know any *#{topic}*."

    end

end
