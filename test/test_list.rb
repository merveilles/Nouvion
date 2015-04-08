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
        answer = Answer.new('list', 'list', 'maxdeviant', 'shirt', 'theartificiallounge', ListMemoryTest.new)
        list = answer.list
        assert_equal 'The only *shirt* I know is _t-shirt_.', list
    end

    def test_list_two_elements
        answer = Answer.new('list', 'list', 'maxdeviant', 'scotch', 'theartificiallounge', ListMemoryTest.new)
        list = answer.list
        assert_equal 'I know 2 kinds of *scotch* : _ardbeg_, _glenmorangie_.', list
    end

    def test_list_no_element
        answer = Answer.new('list', 'list', 'maxdeviant', 'potato', 'theartificiallounge', ListMemoryTest.new)
        list = answer.list
        assert_equal "I don't know any *potato*.", list
    end

    def test_list_duplicates
        answer = Answer.new('list', 'list', 'maxdeviant', 'duptest', 'theartificiallounge', ListMemoryTest.new)
        list = answer.list
        assert_equal 'I know 2 kinds of *duptest* : _a_, _b_.', list
    end

    def test_list_all
        answer = Answer.new('list', 'all', 'maxdeviant', 'list all', 'theartificiallounge', ListMemoryTest.new)
        list = answer.all
        assert_equal 'There are 2 listable topics : _scotch_, _duptest_.', list
    end

    def test_list_help
        answer = Answer.new('list', 'list', 'maxdeviant', '', 'theartificiallounge', ListMemoryTest.new)
        list = answer.list
        assert_equal "List does a reverse query on my memory with the format :\n`ludivine list single malt`\nYou may also query which topics can be listed with `list all`.", list
    end
end

class ListMemoryTest < Memory
    def connect
        #@data = [
        #  ['ludivine', 't-shirt', 'shirt'],
        #  ['ludivine', 'ardbeg', 'scotch'],
        #  ['ludivine', 'glenmorangie', 'scotch'],
        #  ['ludivine', 'a', 'duptest'],
        #  ['ludivine', 'a', 'duptest'],
        #  ['ludivine', 'b', 'duptest']
        #]

        @data = Array.new

        save('ludivine', 't-shirt', 'shirt')
        save('ludivine', 'ardbeg', 'scotch')
        save('ludivine', 'glenmorangie', 'scotch')
        save('ludivine', 'a', 'duptest')
        save('ludivine', 'a', 'duptest')
        save('ludivine', 'b', 'duptest')
    end

    def load(_topic)

        if _topic.strip() == "" then return @data end
        return @data.select { |row| row.include?(_topic) }

    end

    def save(username, key, value)

        lastRow = @data.index { |row| row[0] == username && row[1] == key }

        if lastRow != nil
            @data[lastRow][2] = value
        else
            @data.push([ username, key, value ])
        end

    end
end
