require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestLorem < Minitest::Test
    def setup
        require_relative '../lib/modules/lorem'
    end

    def test_lorem_gibson
        answer = Answer.new('lorem', 'gibson', 'maxdeviant', 'theartificiallounge', 'lorem gibson')

        gibson = answer.gibson

        assert_equal true, (gibson.instance_of? String)
    end
end
