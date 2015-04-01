#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.emote'

class TestEmote < Minitest::Test

    def test_emote_emote

        answer = Answer.new("emote", "emote", "maxdeviant", "ludivine emote", "theartificiallounge")

        emote = answer.emote()

        assert_equal true, (emote.instance_of? Hash)
        assert_equal true, (emote["text"].instance_of? String)

    end

    def test_emote_smile

        answer = Answer.new("emote", "smile", "maxdeviant", "ludivine emote smile", "theartificiallounge")

    end

    def test_cat_fact

        answer = Answer.new("cat", "fact", "maxdeviant", "ludivine cat fact", "theartificiallounge")

        emote = answer.emote()

        assert_equal true, (emote.instance_of? Hash)
        assert_equal true, (emote["text"].instance_of? String)

    end

end
