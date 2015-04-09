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

        assert_includes mem.data, ['ludivine', '{wallet}strstr', '10']
    end

    def test_xenon_give
        mem = XenonMemoryTest.new

        answer = Answer.new('xenon', 'give', 'maxdeviant', 'xenon give greylion 2', 'theartificiallounge', mem)
        emote = answer.give

        assert_includes mem.data, ['ludivine', '{wallet}maxdeviant', '3']
        assert_includes mem.data, ['ludivine', '{wallet}greylion', '10']
    end
end

class XenonMemoryTest < Memory

    attr_reader :data

    def initialize

        @data = Array.new

        saveAttribute('aliceffekt', 'wallet', 10)
        saveAttribute('greylion', 'wallet', 8)
        saveAttribute('maxdeviant', 'wallet', 5)
        saveAttribute('jean', 'wallet', 999)

    end

    def load(_topic)

        if _topic.strip() == "" then return @data end
        return @data.select { |row| row.include?(_topic) }

    end

    def save(username, key, value)

        lastRow = @data.index { |row| row[0] == username && row[1] == key }

        if lastRow != nil 
            @data[lastRow][2] = value
        else
            @data.push([ username, key, value ])
        end

    end    
end
