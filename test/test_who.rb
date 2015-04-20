require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestWho < Minitest::Test
    def setup
        require_relative '../lib/modules/who'
    end

    def test_who_is
        answer = Answer.new('who', 'is', 'maxdeviant', 'theartificiallounge', 'who is aliceffekt')

        is = answer.is

        assert_equal true, (is.instance_of? String)
    end

    def test_who_am
        answer = Answer.new('who', 'am', 'maxdeviant', 'theartificiallounge', 'who am i')

        am = answer.am

        assert_equal true, (am.instance_of? String)
    end

    def test_who_told
        answer = Answer.new('who', 'told', 'maxdeviant', 'theartificiallounge', 'who told you that apple is red')
        assert_equal '*chocobo* told me that _apple_ is _red_.', answer.told
    end

    def test_who_said
        answer = Answer.new('who', 'said', 'maxdeviant', 'theartificiallounge', 'who said that apple is red')
        assert_equal '*chocobo* said that _apple_ is _red_.', answer.said
    end

    def test_who_said_two
        answer = Answer.new('who', 'said', 'maxdeviant', 'theartificiallounge', 'who said that potato is good')
        assert_equal '*renaud*, *maxdeviant* said that _potato_ is _good_.', answer.said
    end

    def test_who_said_nobody
        answer = Answer.new('who', 'said', 'maxdeviant', 'theartificiallounge', 'who said that car is blue')
        assert_equal 'Nobody said that.', answer.said
    end
end

