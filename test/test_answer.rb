require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestAnswer < Minitest::Test
    def setup
    end

    def test_answer_hey
        answer = Answer.new('answer', 'hey', 'maxdeviant', 'theartificiallounge', 'hey')

        hey = answer.hey

        assert_equal 'Hey <@maxdeviant>.', hey
    end

    def test_answer_hi
        answer = Answer.new('answer', 'hi', 'maxdeviant', 'theartificiallounge', 'hi')

        hi = answer.hi

        assert_equal 'Hi <@maxdeviant>!', hi
    end

    def test_answer_sorry
        answer = Answer.new('answer', 'sorry', 'maxdeviant', 'theartificiallounge', 'sorry')

        sorry = answer.sorry

        assert_equal "Don't worry about it <@maxdeviant>.", sorry
    end

    def test_answer_where
        answer = Answer.new('answer', 'where', 'maxdeviant', 'theartificiallounge', 'where')

        where = answer.where

        assert_equal 'You are in <#theartificiallounge>.', where
    end

    def test_answer_rules
        answer = Answer.new('answer', 'rules', 'maxdeviant', 'theartificiallounge', 'rules')

        rules = answer.rules

        assert_equal true, (rules.instance_of? String)
    end
end
