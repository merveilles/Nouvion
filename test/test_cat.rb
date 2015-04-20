require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestCat < Minitest::Test
    def setup
        require_relative '../lib/modules/cat'
    end

    def test_cat_cat
        answer = Answer.new('cat', 'cat', 'maxdeviant', 'theartificiallounge', 'cat')

        fact = answer.cat

        assert_equal true, (fact.instance_of? String)
    end

    def test_cat_fact
        answer = Answer.new('cat', 'fact', 'maxdeviant', 'theartificiallounge', 'cat fact')

        fact = answer.fact

        assert_equal true, (fact.instance_of? String)
    end
end
