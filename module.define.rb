#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer

    def define 

    	splits = @message.strip.split(" ")
    	if splits.length == 0
    		return Hash["text" => "Tell me a word and I'll try to define it."]
    	end

    	word = splits[0]

    	url = "http://api.wordnik.com:80/v4/word.json/#{word}/definitions?limit=1&includeRelated=false&sourceDictionaries=all&useCanonical=true&includeTags=false&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        response = Net::HTTP.get_response(URI.parse(url))
        data = JSON.parse(response.body)

        if response.code != "200"
            if response.code == "404"
                return Hash["text" => "My memory is hazy, sorry."]
            else
                raise "API error"
            end
        end

        return Hash["text" => "*#{word}* is a #{data[0]['partOfSpeech']} that means '#{data[0]['text'].strip}'."]
    end

    #def remember # remember the definition it found
    #end

end