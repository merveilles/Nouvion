require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestWhat < Minitest::Test
    def setup
        require_relative '../lib/modules/what'
    end

    # def test_what_time
    #     answer = Answer.new('what', 'time', 'maxdeviant', 'what time', 'theartificiallounge')

    #     time = answer.time

    #     assert_equal true, (time.instance_of? String)
    # end

    # def test_what_day
    #     answer = Answer.new('what', 'day', 'maxdeviant', 'what day', 'theartificiallounge')

    #     day = answer.day

    #     assert_equal true, (day.instance_of? String)
    # end

    # def test_what_month
    #     answer = Answer.new('what', 'month', 'maxdeviant', 'what month', 'theartificiallounge')

    #     month = answer.month

    #     assert_equal true, (month.instance_of? String)
    # end

    # def test_what_is
    #     answer = Answer.new('what', 'is', 'maxdeviant', 'what is alcohol', 'theartificiallounge', MemoryTest.new)

    #     is = answer.is

    #     assert_equal true, (is.instance_of? String)
    # end
end

