#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer

    def weather 

        return Hash["text" => "Enter a city name to get current weather conditions from OpenWeather API.\nYou can specify country code after a comma.\nExample usage: ```ludivine weather in vancouver,us```"]

    end

    def in # get weather for a city

        cityname = @message.split(" ")[3].lstrip.rstrip

        url = "http://api.openweathermap.org/data/2.5/weather?mode=json&units=metric&q=#{cityname}"
        response = Net::HTTP.get_response(URI.parse(url))
        data = JSON.parse(response.body)

        if data['cod'] != 200
            if data['cod'] = 404
                return Hash["text" => "I couldn't find weather information for a place called \"#{cityname}\", sorry."]
            else
                raise "API error"
            end
        end

        return Hash["text" => "The current weather in *#{data['name']}* (#{data['sys']['country']}) is described as *#{data['weather'].first['description']}*, with a temperature of *#{data['main']['temp']} degrees* Celsius."]

    rescue

        return Hash["text" => "I couldn't get weather information for #{cityname}."]

    end



end