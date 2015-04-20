require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestRecommend < Minitest::Test
    def setup
        require_relative '../lib/modules/recommend'
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
            answer = Answer.new('recommend', 'recommend', 'maxdeviant', 'theartificiallounge', recommendation)

            recommend = answer.recommend

            assert_equal true, (recommend.instance_of? String)
        end
    end
end
