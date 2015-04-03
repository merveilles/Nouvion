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

end
