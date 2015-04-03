#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestLorem < Minitest::Test

    def setup

        require_relative '../module.lorem'

    end

    def test_lorem_gibson

        answer = Answer.new("lorem", "gibson", "maxdeviant", "lorem gibson", "theartificiallounge")

        gibson = answer.gibson()

        assert_equal true, (gibson.instance_of? String)

    end

end
