require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestWeather < Minitest::Test
    def setup
        require_relative '../lib/modules/define'
    end

    def test_define
    end
end
