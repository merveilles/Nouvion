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
        assert_equal "I know 1 kind of *shirt* : _t-shirt_.", list

    end

    def test_list_two_elements

        answer = Answer.new("list", "list", "maxdeviant", "scotch", "theartificiallounge", ListMemoryTest.new())
        list = answer.list()
        assert_equal "I know 2 kinds of *scotch* : _ardbeg_, _glenmorangie_.", list

    end

    def test_list_no_element

        answer = Answer.new("list", "list", "maxdeviant", "potato", "theartificiallounge", ListMemoryTest.new())
        list = answer.list()
        assert_equal "I don't know any *potato*.", list

    end    

    def test_list_help

        answer = Answer.new("list", "list", "maxdeviant", "", "theartificiallounge", ListMemoryTest.new())
        list = answer.list()
        assert_equal "List does a reverse query on my memory. (e.g. _ludivine list single malt_)", list

    end        

end

class ListMemoryTest < Memory

    def load(topic)

        return [
            [ "ludivine", "t-shirt", "shirt" ],
            [ "ludivine", "ardbeg", "scotch" ],
            [ "ludivine", "glenmorangie", "scotch" ],
        ]

    end

end
