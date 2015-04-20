require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestEmote < Minitest::Test
    def setup
        require_relative '../lib/modules/emote'
    end

    def test_emote_emote
        answer = Answer.new('emote', 'emote', 'maxdeviant', 'theartificiallounge', 'emote')

        emote = answer.emote

        assert_equal true, (emote.instance_of? String)
    end

    def test_emote_smile
        answer = Answer.new('emote', 'smile', 'maxdeviant', 'theartificiallounge', 'emote smile')
    end

    def test_cat_fact
        answer = Answer.new('cat', 'fact', 'maxdeviant', 'theartificiallounge', 'cat fact')

        emote = answer.emote

        assert_equal true, (emote.instance_of? String)
    end

    def test_flip
        answer = Answer.new('emote', 'flip', 'strstr', 'theartificiallounge', 'emote flip')

        emote = answer.flip

        assert_equal true, (emote.instance_of? String)

        answer = Answer.new('emote', 'flip', 'strstr', 'theartificiallounge', 'emote flip')

        emote = answer.flip

        assert_equal true, (emote.instance_of? String)

        answer = Answer.new('emote', 'flip', 'strstr', 'theartificiallounge', 'emote flip')

        emote = answer.flip

        assert_equal true, (emote.instance_of? String)

        answer = Answer.new('emote', 'flip', 'strstr', 'theartificiallounge', 'emote flip')

        emote = answer.flip

        assert_equal true, (emote.instance_of? String)
    end
end
