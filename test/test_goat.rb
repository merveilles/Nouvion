require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestGoat < Minitest::Test
    def setup
        require_relative '../lib/modules/goat'
    end

    def test_goat_goat
        answer = Answer.new('goat', 'goat', 'maxdeviant', 'theartificiallounge', 'goat')

        goat = answer.goat

        assert_equal 'What about goats?', goat
    end

    def test_goat_tower
        answer = Answer.new('goat', 'tower', 'maxdeviant', 'theartificiallounge', 'goat tower')

        tower = answer.tower

        assert_equal true, (tower.instance_of? String)
    end

    def test_goat_thrower
        answer = Answer.new('goat', 'thrower', 'maxdeviant', 'theartificiallounge', 'goat thrower')

        thrower = answer.thrower

        assert_equal true, (thrower.instance_of? String)
    end
end
