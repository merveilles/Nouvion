#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestEmote < Minitest::Test

    def setup

        require_relative '../module.emote'

    end

    def test_emote_emote

        answer = Answer.new("emote", "emote", "maxdeviant", "emote", "theartificiallounge")

        emote = answer.emote()

        assert_equal true, (emote.instance_of? Hash)
        assert_equal true, (emote["text"].instance_of? String)

    end

    def test_emote_smile

        answer = Answer.new("emote", "smile", "maxdeviant", "emote smile", "theartificiallounge")

    end

    def test_cat_fact

        answer = Answer.new("cat", "fact", "maxdeviant", "cat fact", "theartificiallounge")

        emote = answer.emote()

        assert_equal true, (emote.instance_of? Hash)
        assert_equal true, (emote["text"].instance_of? String)

    end

end
