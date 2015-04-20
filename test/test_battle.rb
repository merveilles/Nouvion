require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestBattle < Minitest::Test
    def setup
        require_relative '../lib/modules/battle'
    end

    def test_battle_profession
        answer = Answer.new('battle', 'profession', 'strstr', 'theartificiallounge', 'battle profession')

        battle = answer.profession

        answer = Answer.new('battle', 'profession', 'strstr', 'theartificiallounge', 'battle profession rogue')

        battle = answer.profession

        answer = Answer.new('battle', 'profession', 'strstr', 'theartificiallounge', 'battle profession')

        battle = answer.profession

        answer = Answer.new('battle', 'profession', 'strstr', 'theartificiallounge', 'battle profession rogue')

        battle = answer.profession

        answer = Answer.new('battle', 'profession', 'strstr', 'theartificiallounge', 'battle profession potato')

        battle = answer.profession
    end

    def test_battle_attack
        answer = Answer.new('battle', 'attack', 'strstr', 'theartificiallounge', 'battle attack potato')

        battle = answer.attack

        answer = Answer.new('battle', 'profession', 'strstr', 'theartificiallounge', 'battle profession rogue')

        battle = answer.profession

        answer = Answer.new('battle', 'attack', 'strstr', 'theartificiallounge', 'battle attack potato')

        battle = answer.attack

        answer = Answer.new('battle', 'raise', 'strstr', 'theartificiallounge', 'battle raise strstr')

        battle = answer.raise

        answer = Answer.new('battle', 'raise', 'strstr', 'theartificiallounge', 'battle raise potato')

        battle = answer.raise
    end
end
