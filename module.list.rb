#!/bin/env ruby
# encoding: utf-8

class Answer

    def list

        topic = @message.gsub("list", "").strip
        if topic == "" then
            return "List does a reverse query on my memory with the format :\n`ludivine list single malt`\nYou may also query which topics can be listed with `list all`."
        end

        @memory.connect()
        thoughts = @memory.load(topic)

        matches = thoughts.select {|x| x[2].include?(topic) }.map { |x| x[1] }.uniq

        if matches.size() == 1 then
            return "The only *#{topic}* I know is _#{matches[0]}_."
        elsif matches.size() > 1 then
            return "I know #{matches.size()} kinds of *#{topic}* : _#{matches.join("_, _")}_."
        end

        return "I don't know any *#{topic}*."

    end

    def all

        @memory.connect()
        thoughts = @memory.load("")

        matches = thoughts.select.with_index { |x,i| thoughts.index.with_index { |y,j| y[2] == x[2] && j != i } != nil }.map { |x| x[2] }.uniq

        if matches.size() > 0 then
            return "There are #{matches.size()} listable topics : _#{matches.join("_, _")}_."
        end

        return "There are no listable topics."

    end

end
