#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer

    # Available: moduleName,methodName,username,message

    def sing
        artist = @message.split(" ")
        artist.delete("sing")
        artist = artist.join(" ").strip
        ret = "I don't know this artist, sorry"

        url = "http://lyrics.wikia.com/api.php?func=getSong&artist=#{artist}&fmt=json"
        response = Net::HTTP.get_response(URI.parse(url))
        data = JSON.parse(response.body)

        if !data["albums"].empty?

            rndAlbum = data["albums"].sample
            rndSong = rndAlbum["songs"].sample

            url = "http://lyrics.wikia.com/api.php?func=getSong&artist=#{artist}&song=#{rndSong}&fmt=text"
            response = Net::HTTP.get_response(URI.parse(url))

            ret = response.body

            if ret == "We don't currently have a license for these lyrics. Please try again in a few days!"
                ret = "I'm sorry i don't know how to sing it"
            else
                ret = ":notes: " + ret
                ret = ret.gsub("\n"," :notes: \n :notes: ")
                ret = ret + " :notes:"
            end
        end

        return ret
    end

end