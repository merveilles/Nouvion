#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestWhat < Minitest::Test

    def setup

        require_relative '../module.what'

    end

    def test_what_time

        answer = Answer.new("what", "time", "maxdeviant", "what time", "theartificiallounge")

        time = answer.time()

        assert_equal true, (time.instance_of? Hash)
        assert_equal true, (time["text"].instance_of? String)

    end

    def test_what_day

        answer = Answer.new("what", "day", "maxdeviant", "what day", "theartificiallounge")

        day = answer.day()

        assert_equal true, (day.instance_of? Hash)
        assert_equal true, (day["text"].instance_of? String)

    end

    def test_what_month

        answer = Answer.new("what", "month", "maxdeviant", "what month", "theartificiallounge")

        month = answer.month()

        assert_equal true, (month.instance_of? Hash)
        assert_equal true, (month["text"].instance_of? String)

    end

    def test_what_is

        answer = Answer.new("what", "is", "maxdeviant", "what is alcohol", "theartificiallounge", MemoryTest.new())

        is = answer.is()

        assert_equal true, (is.instance_of? Hash)
        assert_equal true, (is["text"].instance_of? String)

    end

end

class MemoryTest < Memory

    def load(query)

        return [
            [ "ludivine", "javascript", "programming language" ],
            [ "ludivine", "beer", "alcohol" ]
        ]

    end

end
