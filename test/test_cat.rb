require 'minitest/autorun'
require_relative '../answer'
require_relative '../module.cat'

class TestCat < Minitest::Test

    def test_cat_cat

        answer = Answer.new("cat", "cat", "maxdeviant", "ludivine cat")

        fact = answer.cat()

        assert_equal "What about cats?", fact["text"]

    end

    def test_cat_fact

        answer = Answer.new("cat", "fact", "maxdeviant", "ludivine cat fact")

        fact = answer.fact()

        assert_equal true, (fact.instance_of? Hash)
        assert_equal true, (fact["text"].instance_of? String)

    end

end
