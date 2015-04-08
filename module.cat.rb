#!/bin/env ruby
# encoding: utf-8

require 'api'

class Answer
    def cat
        fact
    end

    def fact
        cat = API::Cat::Fact.new(@username)

        return cat.fact
    end
end
