#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestWager < Minitest::Test

	def setup
		require_relative '../module.wager'
	end
	
	def givingFunctionFor(array)
		return do |winnerName, amount|
			pre = array[winnerName.to_i]
			array[winnerName.to_i] = pre + amount
		end
	end
	
	def test_wager_redistribution_function_simple
		sum = 10
		winnerCount = 10
		winners = ((0...winnerCount).map {|i| [i.to_s,nil,1]}).shuffle
		winnersAccounts = Array.new(10,1)
		distribute_sum(sum, winners, givingFunctionFor(winnersAccounts))
		assert_equal winnersAccounts, Array.new(10,2)
		puts "winners were seen to in this order: #{winners.to_s}"
	end
	
	def test_wager_redistribution_function_small_remainder
		sum = 11
		winnerCount = 10
		winners = ((0...winnerCount).map {|i| [i.to_s,nil,1]}).shuffle
		winnersAccounts = Array.new(10,1)
		distribute_sum(sum, winners, givingFunctionFor(winnersAccounts))
		histogram = [0,0,0,0]
		for pay in winnersAccounts
			histogram[pay] = histogram[pay] + 1
		end
		assert_equal histogram, [0,0,9,1]
		puts "winners were seen to in this order: #{winners.to_s}"
	end
	
	def test_wager_redistribution_function_larger_remainder
		sum = 16
		winnerCount = 10
		winners = ((0...winnerCount).map {|i| [i.to_s,nil,1]}).shuffle
		winnersAccounts = Array.new(winnerCount,1)
		distribute_sum(sum, winners, givingFunctionFor(winnersAccounts))
		histogram = [0,0,0,0,0]
		for pay in winnersAccounts
			histogram[pay] = histogram[pay] + 1
		end
		assert_equal histogram, [0,0,4,6,0]
		puts "winners were seen to in this order: #{winners.to_s}"
	end
	
	def test_wager_redistribution_function_expect_more_for_greater_in
		sum = 20
		winnerCount = 10
		winners = ((0...winnerCount).map {|i| [i.to_s,nil,1]}).shuffle
		winnersAccounts = Array.new(10,1)
		winners[9] = 2
		distribute_sum(sum, winners, givingFunctionFor(winnersAccounts))
		histogram = [0,0,0,0]
		richestWinnar = 0
		richestWinning = 0
		for i in (0...winners.length)
			if richestWinning < winners[i]
				richestWinnar = i
				richestWinning = winners[i]
			end
		end
		assert_equal richestWinnar, 9
		puts "winners were seen to in this order: #{winners.to_s}"
	end
	
	#aand that's where I'll stop because mocking tests for the other functions when we don't have mock memory functions and I can just test them by using the thing once and then never thinking about it again is extremely unproductive behavior
end