#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer

    def define 

    	splits = @message.sub("define","").strip.split(" ")

    	if splits.length == 0
    		return "Tell me a word and I'll try to define it."
        elsif splits.length > 1
            return "Huh, I only define one word at a time.."
    	end

    	word = splits[0]

    	url = "http://api.wordnik.com:80/v4/word.json/#{word}/definitions?limit=1&includeRelated=false&sourceDictionaries=all&useCanonical=true&includeTags=false&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        response = Net::HTTP.get_response(URI.parse(url))
        data = JSON.parse(response.body)

        if response.code != "200"
            if response.code == "404"
                return "My memory is hazy, sorry."
            else
                raise "API error"
            end
        end

        if data[0]
            return "*#{word}* is a #{data[0]['partOfSpeech']} that means '#{data[0]['text'].strip}'."
        end

        # Check in memory

        username = @message.split(" ")[1].strip

        @memory.connect()
        thoughts = @memory.load(username).shuffle

        thoughts.each do |known|
            if known[1] != username then next end
            return "*"+username+"* is "+known[2]+"."
        end

        return "I do not know what *#{word}* is, sorry."

    end
    

    def lookup

        @memory.connect()
        query = @message.sub("what is", "").strip
        thoughts = @memory.load(query).shuffle

        # No answer
        if thoughts.length < 1 
            return "I don't know what *"+query+"* is, but you can teach me about it \bby typing `remember that "+query+" is ` followed by a short definition."
        end

        keyAnswer = []
        valueAnswer = []

        # Find a a key answer
        thoughts.each do |known|
            if known[1] == query then keyAnswer = known end
            if known[2] == query then valueAnswer = known end
        end

        # Key Answer return
        if keyAnswer[1]

            deepThoughts = @memory.load(keyAnswer[2]).shuffle
            deepAnswer = ""
            deepThoughts.each do |deepKnown|
                if deepKnown[1] == keyAnswer[2] then deepAnswer = deepKnown[2] end
            end

            if deepAnswer != ""
                return "*" + keyAnswer[1] + "* is *" + keyAnswer[2] + "*, "+deepAnswer+"."
            else
                return "*" + keyAnswer[1] + "* is *" + keyAnswer[2] + "*."
            end
        end

        # Value Answer return
        if valueAnswer[1]
            return "I don't know what *" + query + "* is. Is it like *"+valueAnswer[1]+"*?"
        end

        return ".."

    end

    #def remember # remember the definition it found
    #end

end