#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'
require_relative '../module.dc'

def dc_answer(op)
    Answer.new('dc', 'dc', 'aliceffekt', "dc #{op}", 'theartificiallounge').dc
end

class TestDc < Minitest::Test
    def test_dc_noop
        assert_match /^A partial/, dc_answer('')
    end

    def test_dc_help
        assert_match /^A partial/, dc_answer('help')
    end

    def test_dc_add
        assert_equal '42.0', dc_answer('12 20 5 5+++n')
    end

    def test_dc_sub
        assert_equal '10.0', dc_answer('15 5 0--n')
    end

    def test_dc_mult
        assert_equal '33.0', dc_answer('11 3*n')
    end

    def test_dc_div
        assert_equal '4.0', dc_answer('3 120 10/r/n')
    end

    def test_dc_mod
        assert_equal '0.0', dc_answer('27 3%n')
    end

    def test_dc_pow
        assert_equal '9.0', dc_answer('3 2^n')
    end

    def test_dc_sqrt
        assert_equal '4.0', dc_answer('16vn')
    end

    def test_dc_newline
        assert_equal "5.0\n", dc_answer('5p')
    end

    def test_dc_multiline
        assert_equal "5.0\n4.0\n3.0\n2.0", dc_answer('5p1-p1-p1-n')
    end

    def test_dc_singline
        assert_equal '1.02.03.04.05.0', dc_answer('5 4 3 2 1nnnnn')
    end

    def test_dc_dup
        assert_equal '2.02.0', dc_answer('2dnn')
    end

    def test_dc_printstack
        assert_equal "15.0\n36.0\n42.0\n", dc_answer('15 36 42f')
    end

    def test_dc_clear
        assert_equal '1.0', dc_answer('2 3 4 5c1n')
    end

    def test_dc_rev
        assert_equal '0.5', dc_answer('2 1r/n')
    end

    def test_dc_stacklength
        assert_equal '3.0', dc_answer('923 274 12.4zn')
    end

    def test_dc_divmod
        assert_equal "4.0\n0.8\n", dc_answer('4 5~f')
    end

    def test_dc_expmod
        assert_equal '43.0', dc_answer('87 23 44|n')
    end

    def test_dc_register
        assert_equal '5.0', dc_answer('3 5s§cl§n')
    end

    def test_dc_register_emoji
        assert_equal '5.0', dc_answer('3 5s😋cl😋n')
    end

    def test_dc_registerstack
        assert_equal "3.0\n5.0\n", dc_answer('3 5S§S§cL§L§f')
    end

    def test_dc_registerstack_emoji
        assert_equal "3.0\n5.0\n", dc_answer('3 5S😋S😋cL😋L😋f')
    end
end
