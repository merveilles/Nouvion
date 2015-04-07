#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestWho < Minitest::Test

    def setup

        require_relative '../module.who'

    end

    def test_who_is

        answer = Answer.new("who", "is", "maxdeviant", "who is aliceffekt", "theartificiallounge")

        is = answer.is()

        assert_equal true, (is.instance_of? String)

    end

    def test_who_am

        answer = Answer.new("who", "am", "maxdeviant", "who am i", "theartificiallounge")

        am = answer.am()

        assert_equal true, (am.instance_of? String)

    end

    def test_who_told

        answer = Answer.new("who", "told", "maxdeviant", "who told you that apple is red", "theartificiallounge", WhoMemoryTest.new())
        assert_equal "*chocobo* told me that _apple_ is _red_.", answer.told()

    end

    def test_who_said

        answer = Answer.new("who", "said", "maxdeviant", "who said that apple is red", "theartificiallounge", WhoMemoryTest.new())
        assert_equal "*chocobo* said that _apple_ is _red_.", answer.said()

    end    

    def test_who_said_two

        answer = Answer.new("who", "said", "maxdeviant", "who said that potato is good", "theartificiallounge", WhoMemoryTest.new())
        assert_equal "*renaud*, *maxdeviant* said that _potato_ is _good_.", answer.said()

    end        

    def test_who_said_nobody

        answer = Answer.new("who", "said", "maxdeviant", "who said that car is blue", "theartificiallounge", WhoMemoryTest.new())
        assert_equal "Nobody said that.", answer.said()

    end        


end

class WhoMemoryTest < Memory

    def load(topic)

        return [
            [ "renaud", "potato", "good" ],
            [ "aliceffekt", "potato", "bad" ],
            [ "maxdeviant", "potato", "good" ],
            [ "chocobo", "apple", "red" ],
            [ "asmi", "apple", "orangered" ],
            [ "chie", "meat", "delicious" ],
        ]

    end

end
