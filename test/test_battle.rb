#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestBattle < Minitest::Test

    def setup

        require_relative '../module.battle'

    end

    def test_battle_profession

        mem = BattleMemoryTest.new();
        
        answer = Answer.new("battle", "profession", "strstr", "battle profession", "theartificiallounge", mem)
        emote = answer.profession()
        #puts emote #todo : assert that the messages are correct by exposing their result somehow

        answer = Answer.new("battle", "profession", "strstr", "battle profession rogue", "theartificiallounge", mem)
        emote = answer.profession()
        #puts emote
        
        answer = Answer.new("battle", "profession", "strstr", "battle profession", "theartificiallounge", mem)
        emote = answer.profession()
        #puts emote

        answer = Answer.new("battle", "profession", "strstr", "battle profession rogue", "theartificiallounge", mem)
        emote = answer.profession()
        #puts emote

        answer = Answer.new("battle", "profession", "strstr", "battle profession potato", "theartificiallounge", mem)
        emote = answer.profession()
        #puts emote

        assert_equal true, true

    end

end

class BattleMemoryTest < Memory 
  
    def initialize
      @mem = [["ludivine", "potato", "no"], 
              ["strstr", "profession", "mage"],
              ["orange", "seeds", "yes"]]
    end

    def load(query)

        return @mem

    end
    
    def save(owner, key, value)
        if owner == "strstr" then
           @mem[1][1] = key
           @mem[1][2] = value
        end
        
    end
end
