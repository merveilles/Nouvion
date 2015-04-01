#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.tell'

class TestTell < Minitest::Test

    def test_tell_tell

        answer = Answer.new("tell", "tell", "maxdeviant", "tell", "theartificiallounge")

        tell = answer.tell()

        assert_equal "I don't know what to tell you.", tell["text"]

        messages = [
            "tell me something dark",
            "rules",
            "manifesto"
        ]

        messages.each do |message|
            answer = Answer.new("tell", "tell", "maxdeviant", message, "theartificiallounge")

            tell = answer.tell()

            assert_equal true, (tell.instance_of? Hash)
            assert_equal true, (tell["text"].instance_of? String)
        end

    end

end
