#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestHelp < Minitest::Test
    def setup
        require_relative '../module.help'
    end

    def test_help_help
        answer = Answer.new('help', 'help', 'maxdeviant', 'help', 'theartificiallounge')

        help = answer.help

        assert_equal true, (help.instance_of? String)
    end

    def test_help_modules
        answer = Answer.new('help', 'modules', 'maxdeviant', 'help modules', 'theartificiallounge')

        modules = answer.modules

        assert_equal true, (modules.instance_of? String)
    end
end
