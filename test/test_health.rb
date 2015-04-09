# encoding: utf-8

require "coveralls"
Coveralls.wear!

require "minitest/autorun"
require "api"
require_relative "../answer"

class TestHealth < Minitest::Test
    def setup
        require_relative "../module.health"

        @@memory = HealthTestMemory.new
    end

    def test_health_health
        answer = Answer.new("health", "health", "maxdeviant", "health", "theartificiallounge", @@memory)

        health = answer.health

        assert_equal "@maxdeviant: You currently have 7 health.", health

        answer = Answer.new("health", "health", "aliceffekt", "health", "theartificiallounge", @@memory)

        health = answer.health

        assert_equal "@aliceffekt: You are _dead_.", health
    end

    def test_health_all
        answer = Answer.new("health", "health", "maxdeviant", "health all", "theartificiallounge", @@memory)

        all = answer.all

        assert_equal true, (all.instance_of? String)
    end
end

class HealthTestMemory < API::Memory
    attr_reader :memory

    def initialize
        @memory = [
            ["ludivine", "health maxdeviant", "7"],
            ["ludivine", "health aliceffekt", "0"]
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
