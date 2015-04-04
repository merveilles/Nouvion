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
      
        memory = FlipMemoryTest.new()
        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge", memory)
        
        emote1 = answer.flip()

        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge", memory)
        
        emote2 = answer.flip()
        
        assert_equal false, emote1 == emote2
        
        answer = Answer.new("emote", "flip", "strstr", "emote flip", "theartificiallounge",memory)
        
        emote3 = answer.flip()
        
        assert_equal true, emote1 == emote3
    end
end

class FlipMemoryTest < Memory # i'm not entirely sure how to mock the memory component of live...

    @flipped = "no"

    def load(query)

        return @flipped

    end
    
    def save(owner, key, value)
        @flipped = value
    end
end
