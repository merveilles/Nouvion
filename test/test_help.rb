require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestHelp < Minitest::Test
    def setup
        require_relative '../lib/modules/help'
    end

    def test_help_help
        answer = Answer.new('help', 'help', 'maxdeviant', 'theartificiallounge', 'help')

        help = answer.help

        assert_equal true, (help.instance_of? String)
    end

    def test_help_modules
        answer = Answer.new('help', 'modules', 'maxdeviant', 'theartificiallounge', 'help modules')

        modules = answer.modules

        assert_equal true, (modules.instance_of? String)
    end
end
