require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'api'
require_relative '../lib/modules/answer'

class TestHealth < Minitest::Test
    def setup
        require_relative '../lib/modules/health'
    end

    def test_health_health
        answer = Answer.new('health', 'health', 'maxdeviant', 'theartificiallounge', 'health')

        health = answer.health

        assert_equal '@maxdeviant: You currently have 7 health.', health

        answer = Answer.new('health', 'health', 'aliceffekt', 'health')

        health = answer.health

        assert_equal '@aliceffekt: You are _dead_.', health
    end

    def test_health_all
        answer = Answer.new('health', 'health', 'maxdeviant', 'theartificiallounge', 'health all')

        all = answer.all

        assert_equal true, (all.instance_of? String)
    end
end
