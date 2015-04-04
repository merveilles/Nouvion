#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../answer'

class TestSing < Minitest::Test

	def setup
	    require_relative '../module.weather'
	end

	def test_weather

        answer = Answer.new("sing", "sing", "ragekit", "test", "theartificiallounge")

        sing = answer.sing()

        assert_equal true, (sing.instance_of? String)
    end

end