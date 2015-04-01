#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestAnswer < Minitest::Test

    def test_answer_text

        answer = Answer.new("answer", "text", "maxdeviant", "text", "theartificiallounge")

        text = answer.text()

        assert_equal "hello there", text["text"]

    end

    def test_answer_hello

        answer = Answer.new("answer", "hello", "maxdeviant", "hello", "theartificiallounge")

        hello = answer.hello()

        assert_equal "Hello maxdeviant, nice to see you.", hello["text"]

    end

    def test_answer_xoka

        answer = Answer.new("answer", "xoka", "maxdeviant", "xoka", "theartificiallounge")

        xoka = answer.xoka()

        assert_equal "Xoka maxdeviant, nice to see you.", xoka["text"]

    end

    def test_answer_hey

        answer = Answer.new("answer", "hey", "maxdeviant", "hey", "theartificiallounge")

        hey = answer.hey()

        assert_equal "hey maxdeviant.", hey["text"]

    end

    def test_answer_hi

        answer = Answer.new("answer", "hi", "maxdeviant", "hi", "theartificiallounge")

        hi = answer.hi()

        assert_equal "hi maxdeviant!", hi["text"]

    end

    def test_answer_sorry

        answer = Answer.new("answer", "sorry", "maxdeviant", "sorry", "theartificiallounge")

        sorry = answer.sorry()

        assert_equal "Don't worry about it *maxdeviant*.", sorry["text"]

    end

    def test_answer_where

        answer = Answer.new("answer", "where", "maxdeviant", "where", "theartificiallounge")

        where = answer.where()

        assert_equal "You are in *theartificiallounge*.", where["text"]

    end

    def test_answer_rules

        answer = Answer.new("answer", "rules", "maxdeviant", "rules", "theartificiallounge")

        rules = answer.rules()

        assert_equal "Rule #1: You must find yourself a monochromatic avatar.\nRule #2: I, *Ludivine*, am above the law.\n", rules["text"]

    end

end
