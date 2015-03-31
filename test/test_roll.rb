#!/bin/env ruby
# encoding: utf-8

require 'minitest/autorun'
require_relative '../answer'
require_relative '../module.roll'

class TestRoll < Minitest::Test

    def test_roll_dice

        answer = Answer.new("roll", "dice", "maxdeviant", "ludivine roll dice ")

    end

    def test_roll_barrel

        answer = Answer.new("roll", "barrel", "maxdeviant", "ludivine roll barrel ")

        assert_equal "*does a barrel roll*", answer.barrel()["text"]

    end

    def test_roll_cigarette

        answer = Answer.new("roll", "cigarette", "maxdeviant", "ludivine roll cigarette ")

        assert_equal "Sorry, I don't smoke.", answer.cigarette()["text"]

    end

    def test_roll_katamari

        answer = Answer.new("roll", "katamari", "maxdeviant", "ludivine roll katamari ")

        assert_equal "na na   na na na na na na na", answer.katamari()["text"]

    end

end
