#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestRoll < Minitest::Test

    def setup

        require_relative '../module.roll'

    end

    def test_roll_dice

        answer = Answer.new("roll", "dice", "maxdeviant", "roll dice 20", "theartificiallounge")

        dice = answer.dice()

        assert_equal true, (dice.instance_of? Hash)
        assert_equal true, (dice["text"].instance_of? String)

        answer = Answer.new("roll", "dice", "maxdeviant", "roll dice", "theartificiallounge")

        dice = answer.dice()

        assert_equal true, (dice.instance_of? Hash)
        assert_equal true, (dice["text"].instance_of? String)

    end

    def test_roll_barrel

        answer = Answer.new("roll", "barrel", "maxdeviant", "roll barrel ", "theartificiallounge")

        barrel = answer.barrel()

        assert_equal "*does a barrel roll*", barrel["text"]

    end

    def test_roll_cigarette

        answer = Answer.new("roll", "cigarette", "maxdeviant", "roll cigarette ", "theartificiallounge")

        cigarette = answer.cigarette()

        assert_equal "Sorry, I don't smoke.", cigarette["text"]

    end

    def test_roll_katamari

        answer = Answer.new("roll", "katamari", "maxdeviant", "roll katamari ", "theartificiallounge")

        katamari = answer.katamari()

        assert_equal "na na   na na na na na na na", katamari["text"]

    end

end
