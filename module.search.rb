#!/bin/env ruby
# encoding: utf-8

require "erb"
include ERB::Util

class Answer

    def getTerm(msg)
        terms = msg.split(" ")

        if terms.length > 2
            term = terms.drop(2).join(" ")
        end

        term = term != nil ? term.lstrip.rstrip : 'cat fact'
        term = url_encode(term)

        return term
    end

    def search

        terms = @message.split(" ")

        if terms.length > 1
            term = terms.drop(1).join(" ")
        end

        term = term != nil ? term.lstrip.rstrip : 'cat fact'
        term = url_encode(term)

        return Hash["text" => "Is <http://www.google.com/search?q=#{term}&btnI|this> what you're looking for?"]
    end

    def google

        term = getTerm(@message)
        return Hash["text" => "http://www.google.com/search?q=#{term}&btnI"]
    end

    def duckduckgo

        term = getTerm(@message)
        return Hash["text" => "https://duckduckgo.com/?q=!ducky+#{term}+%s"]
    end

end
