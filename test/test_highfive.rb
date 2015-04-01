#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.highfive'

class TestHighFive < Minitest::Test

    def test_highfive_highfive

        answer = Answer.new("highfive", "highfive", "maxdeviant", "ludivine highfive", "theartificiallounge")

        highfive = answer.highfive()

        assert_equal true, (highfive.instance_of? Hash)
        assert_equal true, (highfive["text"].instance_of? String)

    end

end
