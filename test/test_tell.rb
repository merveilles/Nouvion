require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestTell < Minitest::Test
    def setup
        require_relative '../lib/modules/tell'
    end

    def test_tell_tell
        answer = Answer.new('tell', 'tell', 'maxdeviant', 'theartificiallounge', 'tell')

        tell = answer.tell

        assert_equal "<@maxdeviant>: I don't know what to tell you.", tell

        messages = [
            'tell me something dark',
            'rules',
            'manifesto'
        ]

        messages.each do |message|
            answer = Answer.new('tell', 'tell', 'maxdeviant', 'theartificiallounge', message)

            tell = answer.tell

            assert_equal true, (tell.instance_of? String)
        end
    end
end
