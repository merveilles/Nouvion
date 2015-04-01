#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.roll'

class TestRoll < Minitest::Test

    def test_roll_dice

        answer = Answer.new("roll", "dice", "maxdeviant", "ludivine roll dice 20", "theartificiallounge")

        dice = answer.dice()

        assert_equal true, (dice.instance_of? Hash)
        assert_equal true, (dice["text"].instance_of? String)

        answer = Answer.new("roll", "dice", "maxdeviant", "ludivine roll dice", "theartificiallounge")

        dice = answer.dice()

        assert_equal true, (dice.instance_of? Hash)
        assert_equal true, (dice["text"].instance_of? String)

    end

    def test_roll_barrel

        answer = Answer.new("roll", "barrel", "maxdeviant", "ludivine roll barrel ", "theartificiallounge")

        barrel = answer.barrel()

        assert_equal "*does a barrel roll*", barrel["text"]

    end

    def test_roll_cigarette

        answer = Answer.new("roll", "cigarette", "maxdeviant", "ludivine roll cigarette ", "theartificiallounge")

        cigarette = answer.cigarette()

        assert_equal "Sorry, I don't smoke.", cigarette["text"]

    end

    def test_roll_katamari

        answer = Answer.new("roll", "katamari", "maxdeviant", "ludivine roll katamari ", "theartificiallounge")

        katamari = answer.katamari()

        assert_equal "na na   na na na na na na na", katamari["text"]

    end

end
