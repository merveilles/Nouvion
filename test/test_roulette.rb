require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'api'
require_relative '../lib/modules/answer'

class TestRoulette < Minitest::Test
    def setup
        require_relative '../lib/modules/roulette'
    end

    def test_roulette_roulette
        answer = Answer.new('roulette', 'roulette', 'maxdeviant', 'theartificiallounge', 'roulette')

        roulette = answer.roulette

        assert_equal true, roulette.instance_of?(String)
    end

    def test_roulette_load
        answer = Answer.new('roulette', 'load', 'maxdeviant', 'theartificiallounge', 'roulette load')

        load = answer.load

        assert_equal true, load.include?('a bullet in the revolver.')

    end

    def test_roulette_spin
        answer = Answer.new('roulette', 'spin', 'maxdeviant', 'theartificiallounge', 'roulette spin')

        spin = answer.spin

        assert_equal '<@maxdeviant> spins the cylinder. :return:', spin
    end

    def test_roulette_pull
        answer = Answer.new('roulette', 'pull', 'maxdeviant', 'theartificiallounge', 'roulette pull')

        pull = answer.pull

        assert_equal true, pull.instance_of?(String)
    end
end
