#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.recommend'

class TestRecommend < Minitest::Test

    def test_recommend_recommend

        recommendations = [
            "alcohol",
            "programming language",
            "alcohol for aliceffekt",
            "programming language for aliceffekt",
            "for the win for aliceffekt"
        ]

        recommendations.each do |recommendation|
            answer = Answer.new("recommend", "recommend", "maxdeviant", recommendation, "theartificiallounge", MemoryTest.new())

            recommend = answer.recommend()

            assert_equal true, (recommend.instance_of? Hash)
            assert_equal true, (recommend["text"].instance_of? String)
        end

    end

end

class MemoryTest < Memory

    def load(topic)

        return [
            [ "ludivine", "javascript", "programming language" ],
            [ "ludivine", "beer", "alcohol" ],
            [ "ludivine", "win", "for the win" ]
        ]

    end

end
