require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestWeather < Minitest::Test
    def setup
        require_relative '../lib/modules/weather'
    end

    # TODO: add tests for API success/failure

    def test_weather
        answer = Answer.new('weather', 'weather', 'amatecha', 'weather', 'theartificiallounge')

        weather = answer.weather

        assert_equal true, (weather.instance_of? String)
        assert_equal "Enter a city name to get current weather conditions from OpenWeather API.\nExample usage: ```ludivine weather in vancouver```", weather
    end

    def test_weather_in
        answer = Answer.new('weather', 'in', 'amatecha', 'weather in Vancouver', 'theartificiallounge')

        weather = answer.in

        assert_equal true, (weather.instance_of? String)
    end
end
