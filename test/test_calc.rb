#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestCalc < Minitest::Test

    def setup

        require_relative '../module.calc'

    end

    def test_calc_add

        # Need to double check this test case
        answer = Answer.new("calc", "add", "maxdeviant", "calc add 1 1", "theartificiallounge")

        add = answer.add()

        assert_equal "The sum of 1 and 1, is 2.", add["text"]

    end

    def test_calc_subtract

        answer = Answer.new("calc", "subtract", "maxdeviant", "calc subtract 5 3", "theartificiallounge")

        subtract = answer.subtract()

        assert_equal "The difference of 3 subtracted from 5, is 2.", subtract["text"]

    end

    def test_calc_multiply

        answer = Answer.new("calc", "multiply", "maxdeviant", "calc multiply 4 4", "theartificiallounge")

        multiply = answer.multiply()

        assert_equal "The product of 4 and 4, is 16.", multiply["text"]

    end

    def test_calc_divide

        answer = Answer.new("calc", "divide", "maxdeviant", "calc divide 3 4", "theartificiallounge")

        divide = answer.divide()

        assert_equal "The dividend of 3 divided by 4, is 0.75.", divide["text"]

    end

end
