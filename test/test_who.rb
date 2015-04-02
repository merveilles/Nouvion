#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../module.who'

class TestWho < Minitest::Test

    def test_who_is

        answer = Who.new("who", "is", "maxdeviant", "who is aliceffekt", "theartificiallounge")

        is = answer.is()

        assert_equal true, (is.instance_of? Hash)
        assert_equal true, (is["text"].instance_of? String)

    end

    def test_who_am

        answer = Who.new("who", "am", "maxdeviant", "who am i", "theartificiallounge")

        am = answer.am()

        assert_equal true, (am.instance_of? Hash)
        assert_equal true, (am["text"].instance_of? String)

    end

end
