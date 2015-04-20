require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestHighFive < Minitest::Test
    def setup
        require_relative '../lib/modules/highfive'
    end

    def test_highfive_highfive
        answer = Answer.new('highfive', 'highfive', 'maxdeviant', 'theartificiallounge', 'highfive')

        highfive = answer.highfive

        assert_equal true, (highfive.instance_of? String)
    end
end
