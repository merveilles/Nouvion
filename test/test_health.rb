#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestHealth < Minitest::Test
    def setup
        require_relative '../module.health'

        @@memory = HealthMemoryTest.new
    end

    def test_health_health
        answer = Answer.new('health', 'health', 'maxdeviant', 'health', 'theartificiallounge', @@memory)

        health = answer.health

        assert_equal '@maxdeviant: You currently have 7 health.', health

        answer = Answer.new('health', 'health', 'aliceffekt', 'health', 'theartificiallounge', @@memory)

        health = answer.health

        assert_equal '@aliceffekt: You are _dead_.', health
    end

    def test_health_all
        answer = Answer.new('health', 'health', 'maxdeviant', 'health all', 'theartificiallounge', @@memory)

        all = answer.all

        assert_equal true, (all.instance_of? String)
    end
end

class HealthMemoryTest < Memory
    attr_reader :memory

    def initialize
        @memory = [
          ['ludivine', 'health maxdeviant', '7'],
          ['ludivine', 'health aliceffekt', '0'],
        ]
    end

    def load(query)
        @memory.select { |m| m[1].include? query }
    end

    def save(_owner, _key, _value)
    end
end
