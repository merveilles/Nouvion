#!/bin/env ruby
# encoding: utf-8

class Answer
    def recommend
        message = @message.gsub('recommend', '').strip.split(' ')

        for_index = message.rindex('for')

        if !for_index.nil?
            topic = message.take(for_index).join(' ')
            target = message.drop(for_index + 1).join(' ')
        else
            topic = message.join(' ')
            target = @username
        end

        @memory.connect
        thoughts = @memory.load(topic).shuffle

        thoughts.each do |known|
            unless known[2].include?(topic) then next end

            return "How about *#{known[1]}*, <@#{target}>?"
        end

        "<@#{@username}>: What is *#{topic}*?"
    end
end
