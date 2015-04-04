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

        url = URI.escape(url)

        response = Net::HTTP.get_response(URI.parse(url))
        data = JSON.parse(response.body)

        if !data["albums"].empty?

            rndAlbum = data["albums"].shuffle[0]
            rndSong = rndAlbum["songs"].shuffle[0]

            url = "http://lyrics.wikia.com/api.php?func=getSong&artist=#{artist}&song=#{rndSong}&fmt=text"
            url = URI.escape(url)
            response = Net::HTTP.get_response(URI.parse(url))

            ret = response.body

            if ret == "We don't currently have a license for these lyrics. Please try again in a few days!"
                ret = "I'm sorry i don't know how to sing it"
            else
                ret = ret.lines()
                ret.delete("\n")
                ret = ret[0...4]
                ret = ret.collect { |x| ":notes: " + x }
                ret = ret.join()                
            end
        end

        return ret
    end

end