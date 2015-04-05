#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../battle'

class TestBattle < Minitest::Test

    def setup

        require_relative '../module.battle'

    end

    def test_battle_profession

        answer = Answer.new("battle", "battle", "strstr", "battle profession", "theartificiallounge")

        emote = answer.emote()

        assert_equal true, (emote.instance_of? String)

    end

end
