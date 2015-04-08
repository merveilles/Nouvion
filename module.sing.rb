#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer

    # Available: moduleName,methodName,username,message

    def sing

        if @message.strip == "sing"
            return help
        end

        artist = @message.split(" ")
        artist.delete("sing")

        ret = "I don't know this artist, sorry"

        if (artist.include? "aliceffekt")
            return ":notes: _instrumental_"
        end

        if (artist.include? "sandstorm") || (artist.include? "darude")
            return ":notes: DU DU DU DU DU"
        end

        if artist.include? "by"
            argv = artist

            by_index = argv.find_index "by"
            song = argv[0...by_index].join(" ")
            artist = argv[by_index+1...argv.length].join(" ")

            url = "http://lyrics.wikia.com/api.php?func=getSong&artist=#{artist}&song=#{song}&fmt=text"
            url = URI.escape(url)
            response = Net::HTTP.get_response(URI.parse(url))
            ret = response.body

            if ret == "We don't currently have a license for these lyrics. Please try again in a few days!"
                ret = "I'm sorry i don't know how to sing it"
            else
                ret= ret.each_line.reject{|x| x.strip == ""}[0...4].collect { |x| ":notes: " + x }.join
            end

            return ret
        else
            artist = artist.join(" ").strip

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
                    ret= ret.each_line.reject{|x| x.strip == ""}[0...4].collect { |x| ":notes: " + x }.join
                end
            end
        end

        return ret

    end


    def help

        return "Make me sing a random artist song by calling `ludivine sing artist` or a specific one with `ludivine sing song by artist`"
    end

end