require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestRoll < Minitest::Test
    def setup
        require_relative '../lib/modules/roll'
    end

    def test_roll_dice
        answer = Answer.new('roll', 'dice', 'maxdeviant', 'theartificiallounge', 'roll dice 20')

        dice = answer.dice

        assert_equal true, (dice.instance_of? String)

        answer = Answer.new('roll', 'dice', 'maxdeviant', 'theartificiallounge', 'roll dice')

        dice = answer.dice

        assert_equal true, (dice.instance_of? String)
    end

    def test_roll_barrel
        answer = Answer.new('roll', 'barrel', 'maxdeviant', 'theartificiallounge', 'roll barrel ')

        barrel = answer.barrel

        assert_equal '*does a barrel roll*', barrel
    end

    def test_roll_cigarette
        answer = Answer.new('roll', 'cigarette', 'maxdeviant', 'theartificiallounge', 'roll cigarette ')

        cigarette = answer.cigarette

        assert_equal "Sorry, I don't smoke.", cigarette
    end

    def test_roll_katamari
        answer = Answer.new('roll', 'katamari', 'maxdeviant', 'theartificiallounge', 'roll katamari ')

        katamari = answer.katamari

        assert_equal 'na na   na na na na na na na', katamari
    end
end
