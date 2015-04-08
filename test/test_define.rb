#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestWeather < Minitest::Test
    def setup
        require_relative '../module.define'
    end

    def test_define
    end
end
