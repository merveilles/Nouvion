#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestCat < Minitest::Test

    def setup

        require_relative '../module.cat'

    end

    def test_cat_cat

        answer = Answer.new("cat", "cat", "maxdeviant", "cat", "theartificiallounge")

        fact = answer.cat()

        assert_equal "What about cats?", fact["text"]

    end

    def test_cat_fact

        answer = Answer.new("cat", "fact", "maxdeviant", "cat fact", "theartificiallounge")

        fact = answer.fact()

        assert_equal true, (fact.instance_of? Hash)
        assert_equal true, (fact["text"].instance_of? String)

    end

end
