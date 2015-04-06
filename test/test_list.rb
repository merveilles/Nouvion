#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestList < Minitest::Test

    def setup

        require_relative '../module.list'

    end

    def test_list_one_element

        answer = Answer.new("list", "list", "maxdeviant", "shirt", "theartificiallounge", ListMemoryTest.new())
        list = answer.list()
        assert_equal "I know 1 kind of *shirt* : *t-shirt*.", list

    end

    def test_list_two_elements

        answer = Answer.new("list", "list", "maxdeviant", "scotch", "theartificiallounge", ListMemoryTest.new())
        list = answer.list()
        assert_equal "I know 2 kinds of *scotch* : *ardbeg*, *glenmorangie*.", list

    end

    def test_list_no_element

        answer = Answer.new("list", "list", "maxdeviant", "potato", "theartificiallounge", ListMemoryTest.new())
        list = answer.list()
        assert_equal "I don't know any *potato*.", list

    end    

end

class ListMemoryTest < Memory

    def load(topic)

        return [
            [ "ludivine", "t-shirt", ["shirt"] ],
            [ "ludivine", "ardbeg", ["scotch"] ],
            [ "ludivine", "glenmorangie", ["scotch"] ],
        ]

    end

end
