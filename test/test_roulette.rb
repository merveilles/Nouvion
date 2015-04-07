#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestRoulette < Minitest::Test

    def setup

        require_relative '../module.roulette'

    end

    def test_roulette_roulette

        answer = Answer.new("roulette", "roulette", "maxdeviant", "roulette", "theartificiallounge")

        roulette = answer.roulette()

        assert_equal true, (roulette.instance_of? String)
    end

end
