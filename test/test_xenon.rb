#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestXenon < Minitest::Test

    def setup

        require_relative '../module.xenon'

    end
    
    def test_xenon_account
        mem = XenonMemoryTest.new()
        
        answer = Answer.new("xenon", "account", "strstr", "xenon account", "theartificiallounge", mem)
        emote = answer.account()
        assert mem.mem[4][0] == "ludivine" && mem.mem[4][1] == "wallet strstr" && mem.mem[4][2] == "10"         

        answer = Answer.new("xenon", "give", "maxdeviant", "xenon give greylion 2", "theartificiallounge", mem)
        emote = answer.give()
        
        assert mem.mem[2][0] == "ludivine" && mem.mem[2][1] == "wallet maxdeviant" && mem.mem[2][2] == "3"
        assert mem.mem[1][0] == "ludivine" && mem.mem[1][1] == "wallet greylion" && mem.mem[1][2] == "10"
        
    end
    
    def test_xenon_give
      
    end
    
end

class XenonMemoryTest < Memory
    
    attr_reader :mem
    
    def initialize
        @mem = [[ "ludivine", "wallet aliceffekt", "10" ],
                [ "ludivine", "wallet greylion", "8" ],
                [ "ludivine", "wallet maxdeviant", "5" ],
                [ "ludivine", "wallet jean", "999" ]]   
    end

    def load(query)

        return @mem

    end

    def save(stuffA, stuffB, stuffC)
      if stuffB == "wallet aliceffekt" then
        @mem[0][2] = stuffC
      elsif stuffB == "wallet greylion" then
        @mem[1][2] = stuffC
      elsif stuffB == "wallet maxdeviant" then
        @mem[2][2] = stuffC
      elsif stuffB == "wallet jean" then
        @mem[3][2] = stuffC
      else
        @mem += [[stuffA, stuffB, stuffC]] 
      end
    end

end

