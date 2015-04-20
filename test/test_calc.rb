require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../lib/modules/answer'

class TestCalc < Minitest::Test
    def setup
        require_relative '../lib/modules/calc'
    end

    def test_calc_add
        # Need to double check this test case
        answer = Answer.new('calc', 'add', 'maxdeviant', 'theartificiallounge', 'calc add 1 1')

        add = answer.add

        assert_equal 'The sum of 1 and 1, is 2.', add
    end

    def test_calc_subtract
        answer = Answer.new('calc', 'subtract', 'maxdeviant', 'theartificiallounge', 'calc subtract 5 3')

        subtract = answer.subtract

        assert_equal 'The difference of 3 subtracted from 5, is 2.', subtract
    end

    def test_calc_multiply
        answer = Answer.new('calc', 'multiply', 'maxdeviant', 'theartificiallounge', 'calc multiply 4 4')

        multiply = answer.multiply

        assert_equal 'The product of 4 and 4, is 16.', multiply
    end

    def test_calc_divide
        answer = Answer.new('calc', 'divide', 'maxdeviant', 'theartificiallounge', 'calc divide 3 4')

        divide = answer.divide

        assert_equal 'The dividend of 3 divided by 4, is 0.75.', divide
    end
end
