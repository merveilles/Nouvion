#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestRecommend < Minitest::Test
    def setup
        require_relative '../module.recommend'
    end

    def test_recommend_recommend
        recommendations = [
          'alcohol',
          'programming language',
          'alcohol for aliceffekt',
          'programming language for aliceffekt',
          'for the win for aliceffekt'
        ]

        recommendations.each do |recommendation|
            answer = Answer.new('recommend', 'recommend', 'maxdeviant', recommendation, 'theartificiallounge', MemoryTest.new)

            recommend = answer.recommend

            assert_equal true, (recommend.instance_of? String)
        end
    end
end

class MemoryTest < Memory
    def load(_topic)
        [
          ['ludivine', 'javascript', 'programming language'],
          %w(ludivine beer alcohol),
          ['ludivine', 'win', 'for the win']
        ]
    end
end
