#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestXenon < Minitest::Test
    def setup
        require_relative '../module.xenon'
    end

    def test_xenon_account
        mem = XenonMemoryTest.new

        answer = Answer.new('xenon', 'account', 'strstr', 'xenon account', 'theartificiallounge', mem)
        emote = answer.account

        assert_includes mem.mem, ['ludivine', 'wallet strstr', '10']
    end

    def test_xenon_give
        mem = XenonMemoryTest.new

        answer = Answer.new('xenon', 'give', 'maxdeviant', 'xenon give greylion 2', 'theartificiallounge', mem)
        emote = answer.give

        assert_includes mem.mem, ['ludivine', 'wallet maxdeviant', '3']
        assert_includes mem.mem, ['ludivine', 'wallet greylion', '10']
    end
end

class XenonMemoryTest < Memory
    attr_reader :mem

    def initialize
        @mem = [['ludivine', 'wallet aliceffekt', '10'],
                ['ludivine', 'wallet greylion', '8'],
                ['ludivine', 'wallet maxdeviant', '5'],
                ['ludivine', 'wallet jean', '999']]
    end

    def load(_query)
        @mem
    end

    def save(stuffA, stuffB, stuffC)
      if stuffB == 'wallet aliceffekt'
        @mem[0][2] = stuffC
      elsif stuffB == 'wallet greylion'
        @mem[1][2] = stuffC
      elsif stuffB == 'wallet maxdeviant'
        @mem[2][2] = stuffC
      elsif stuffB == 'wallet jean'
        @mem[3][2] = stuffC
      else
        @mem += [[stuffA, stuffB, stuffC]]
      end
    end
end
