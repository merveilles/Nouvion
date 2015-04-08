#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestHighFive < Minitest::Test
    def setup
        require_relative '../module.highfive'
    end

    def test_highfive_highfive
        answer = Answer.new('highfive', 'highfive', 'maxdeviant', 'highfive', 'theartificiallounge')

        highfive = answer.highfive

        assert_equal true, (highfive.instance_of? String)
    end
end
