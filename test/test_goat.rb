#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestGoat < Minitest::Test

    def setup

        require_relative '../module.goat'

    end

    def test_goat_goat

        answer = Answer.new("goat", "goat", "maxdeviant", "goat", "theartificiallounge")

        goat = answer.goat()

        assert_equal "What about goats?", goat

    end

    def test_goat_tower

        answer = Answer.new("goat", "tower", "maxdeviant", "goat tower", "theartificiallounge")

        tower = answer.tower()

        assert_equal true, (tower.instance_of? String)

    end

    def test_goat_thrower

        answer = Answer.new("goat", "thrower", "maxdeviant", "goat thrower", "theartificiallounge")

        thrower = answer.thrower()

        assert_equal true, (thrower.instance_of? String)

    end

end
