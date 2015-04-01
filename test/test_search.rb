#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.search'

class TestSearch < Minitest::Test

    def test_search_google

        answer = Answer.new("search", "google", "maxdeviant", "google cat fact", "theartificiallounge")

        google = answer.google()

        assert_equal "http://www.google.com/search?q=cat%20fact&btnI", google["text"]

    end

    def test_search_duckduckgo

        answer = Answer.new("search", "duckduckgo", "maxdeviant", "search duckduckgo cat fact", "theartificiallounge")

        duckduckgo = answer.duckduckgo()

        assert_equal "https://duckduckgo.com/?q=!ducky+duckduckgo%20cat%20fact+%s", duckduckgo["text"]

    end

end
