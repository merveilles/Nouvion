#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.who'

class TestWho < Minitest::Test

    def test_who_is

        answer = Answer.new("who", "is", "maxdeviant", "ludivine who is aliceffekt", "theartificiallounge")

        is = answer.is()

        assert_equal "*@aliceffekt* is many witches.", is["text"]

        answer = Answer.new("who", "is", "maxdeviant", "ludivine who is maxdeviant", "theartificiallounge")

        is = answer.is()

        assert_equal "You are actually Marshall.", is["text"]

        answer = Answer.new("who", "is", "maxdeviant", "ludivine who is name-that-does-not-exist", "theartificiallounge")

        is = answer.is()

        assert_equal "I do not know *name-that-does-not-exist*.", is["text"]

    end

    def test_who_am

        answer = Answer.new("who", "am", "maxdeviant", "ludivine who am i", "theartificiallounge")

        am = answer.am()

        assert_equal "You are actually Marshall.", am["text"]

        answer = Answer.new("who", "am", "name-that-does-not-exist", "ludivine who am i", "theartificiallounge")

        am = answer.am()

        assert_equal "I do not know you.", am["text"]

    end

end
