require 'minitest/autorun'
require_relative '../answer'
require_relative '../module.cat'

class TestCalc < Minitest::Test

    def test_cat_fact

        answer = Answer.new("cat", "fact", "maxdeviant", "ludivine cat fact")

        fact = answer.fact()

        assert_equal true, (fact.instance_of? Hash)
        assert_equal true, (fact["text"].instance_of? String)

    end

end
