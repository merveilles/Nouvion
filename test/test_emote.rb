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

        assert_equal true, (emote.instance_of? String)

    end

    def test_emote_smile

        answer = Answer.new("emote", "smile", "maxdeviant", "emote smile", "theartificiallounge")

    end

    def test_cat_fact

        answer = Answer.new("cat", "fact", "maxdeviant", "cat fact", "theartificiallounge")

        emote = answer.emote()

        assert_equal true, (emote.instance_of? String)

    end

    def test_flip
      
        # mock memory
        memory = FlipMemoryTest.new()
        
        # flip once...
        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge", memory)
        emote1 = answer.flip()
        assert_equal true, answer.flippingEmojis.include?(emote1)

        # unflip
        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge", memory)
        emote2 = answer.flip()
        assert_equal true, answer.unflippingEmojis.include?(emote2)
        
        # flip again
        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge",memory)
        emote3 = answer.flip()
        assert_equal true, answer.flippingEmojis.include?(emote3)
        
        # and confirm unflip
        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge",memory)
        emote4 = answer.flip()
        assert_equal true, answer.unflippingEmojis.include?(emote4)
    end
end

class FlipMemoryTest < Memory 
  
    def initialize
      @mem = [["ludivine", "table flipped", "no"], ["ludivine", "other thing", "potato"]]
    end

    def load(query)

        return @mem

    end
    
    def save(owner, key, value)
        @mem[0][2] = value
    end
end
