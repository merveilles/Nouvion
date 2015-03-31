#!/bin/env ruby
# encoding: utf-8

require 'minitest/autorun'
require 'coveralls'
require 'memory'
require_relative '../answer'
require_relative '../module.calc'

Coveralls.wear!

class TestCalc < Minitest::Test

    def test_calc_add

        # Need to double check this test case
        answer = Answer.new("calc", "add", "maxdeviant", "ludivine calc add 1 1", "theartificiallounge")

        assert_equal "The sum of 0 and 1, is 1.", answer.add()["text"]

    end

end
