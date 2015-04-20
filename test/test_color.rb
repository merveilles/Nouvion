require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestColor < Minitest::Test
    def setup
        require_relative '../lib/modules/color'
    end

    def test_color_color
        answer = Answer.new('color', 'color', 'maxdeviant', 'theartificiallounge', 'color')

        color = answer.color

        assert_equal true, (color.instance_of? String)
    end

    def test_color_random
        answer = Answer.new('color', 'random', 'maxdeviant', 'theartificiallounge', 'color random')

        random = answer.random

        assert_equal true, (random.instance_of? String)
    end

    def test_color_today
        answer = Answer.new('color', 'today', 'maxdeviant', 'theartificiallounge', 'color today')

        today = answer.today

        assert_equal true, (today.instance_of? String)
    end

    def test_color_aura
        answer = Answer.new('color', 'aura', 'maxdeviant', 'theartificiallounge', 'color aura')

        aura = answer.aura

        assert_equal true, (aura.instance_of? String)
    end
end
