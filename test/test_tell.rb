#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestTell < Minitest::Test
    def setup
        require_relative '../module.tell'
    end

    def test_tell_tell
        answer = Answer.new('tell', 'tell', 'maxdeviant', 'tell', 'theartificiallounge')

        tell = answer.tell

        assert_equal "I don't know what to tell you.", tell

        messages = [
          'tell me something dark',
          'rules',
          'manifesto'
        ]

        messages.each do |message|
            answer = Answer.new('tell', 'tell', 'maxdeviant', message, 'theartificiallounge')

            tell = answer.tell

            assert_equal true, (tell.instance_of? String)
        end
    end
end
