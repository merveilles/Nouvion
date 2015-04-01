#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.color'

class TestColor < Minitest::Test

    def test_color_color

        answer = Answer.new("color", "color", "maxdeviant", "ludivine color", "theartificiallounge")

        color = answer.color()

        assert_equal "What about colors?", color["text"]

    end

    def test_color_random

        answer = Answer.new("color", "random", "maxdeviant", "ludivine color random", "theartificiallounge")

        random = answer.random()

        assert_equal true, (random.instance_of? Hash)
        assert_equal true, (random["text"].instance_of? String)

    end

    def test_color_today

        answer = Answer.new("color", "today", "maxdeviant", "ludivine color today", "theartificiallounge")

        today = answer.today()

        assert_equal true, (today.instance_of? Hash)
        assert_equal true, (today["text"].instance_of? String)

    end

    def test_color_aura

        answer = Answer.new("color", "aura", "maxdeviant", "ludivine color aura", "theartificiallounge")

        aura = answer.aura()

        assert_equal true, (aura.instance_of? Hash)
        assert_equal true, (aura["text"].instance_of? String)

    end

end
