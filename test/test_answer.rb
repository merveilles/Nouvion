#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestAnswer < Minitest::Test

    def setup

    end

    def test_answer_hey

        answer = Answer.new("answer", "hey", "maxdeviant", "hey", "theartificiallounge")

        hey = answer.hey()

        assert_equal "hey maxdeviant.", hey

    end

    def test_answer_hi

        answer = Answer.new("answer", "hi", "maxdeviant", "hi", "theartificiallounge")

        hi = answer.hi()

        assert_equal "hi maxdeviant!", hi

    end

    def test_answer_sorry

        answer = Answer.new("answer", "sorry", "maxdeviant", "sorry", "theartificiallounge")

        sorry = answer.sorry()

        assert_equal "Don't worry about it *maxdeviant*.", sorry

    end

    def test_answer_where

        answer = Answer.new("answer", "where", "maxdeviant", "where", "theartificiallounge")

        where = answer.where()

        assert_equal "You are in *theartificiallounge*.", where

    end

    def test_answer_rules

        answer = Answer.new("answer", "rules", "maxdeviant", "rules", "theartificiallounge")

        rules = answer.rules()

        assert_equal true, (rules.instance_of? String)

    end

end
