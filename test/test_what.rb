#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../module.what'

class TestWhat < Minitest::Test

    def test_what_time

        answer = What.new("what", "time", "maxdeviant", "what time", "theartificiallounge")

        time = answer.time()

        assert_equal true, (time.instance_of? Hash)
        assert_equal true, (time["text"].instance_of? String)

    end

    def test_what_day

        answer = What.new("what", "day", "maxdeviant", "what day", "theartificiallounge")

        day = answer.day()

        assert_equal true, (day.instance_of? Hash)
        assert_equal true, (day["text"].instance_of? String)

    end

    def test_what_month

        answer = What.new("what", "month", "maxdeviant", "what month", "theartificiallounge")

        month = answer.month()

        assert_equal true, (month.instance_of? Hash)
        assert_equal true, (month["text"].instance_of? String)

    end

    def test_what_is

        answer = What.new("what", "is", "maxdeviant", "what is alcohol", "theartificiallounge", MemoryTest.new())

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
