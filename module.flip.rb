#!/bin/env ruby
# encoding: utf-8

class Answer
    def flip
        if rand(2) < 1:
            "Heads."
        else 
            "Tails."
        end
    end
end
