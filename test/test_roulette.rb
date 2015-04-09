#!/bin/env ruby
# encoding: utf-8

require "coveralls"
Coveralls.wear!

require "minitest/autorun"
require "api"
require_relative "../answer"

class TestRoulette < Minitest::Test
    def setup
        require_relative "../module.roulette"

        @@memory = RouletteTestMemory.new
    end

    def test_roulette_roulette
        answer = Answer.new("roulette", "roulette", "maxdeviant", "roulette", "theartificiallounge")

        roulette = answer.roulette

        assert_equal true, roulette.instance_of?(String)
    end

    def test_roulette_load
        answer = Answer.new("roulette", "load", "maxdeviant", "roulette load", "theartificiallounge", @@memory)

        load = answer.load

        assert_equal "@maxdeviant: You put a bullet in the revolver. :japanese_ogre:", load

    end

    def test_roulette_spin
        answer = Answer.new("roulette", "spin", "maxdeviant", "roulette spin", "theartificiallounge", @@memory)

        spin = answer.spin

        assert_equal "maxdeviant spins the cylinder. :return:", spin
    end

    def test_roulette_pull
        answer = Answer.new("roulette", "pull", "maxdeviant", "roulette pull", "theartificiallounge", @@memory)

        pull = answer.pull

        assert_equal true, pull.instance_of?(String)
    end
end

class RouletteTestMemory < Memory
    attr_reader :memory

    def initialize
        @memory = [
            ["ludivine", "health maxdeviant", "7"],
            ["ludivine", "health aliceffekt", "0"],
            ["ludivine", "roulette chamber", "000000"]
        ]
    end

    def connect

    end

    def save(owner, key, value)
        if key == "roulette chamber"
            @memory[2][2] = value
        end
    end

    def load(query)
        @memory.select { |m| m[1].include? query }
    end
end