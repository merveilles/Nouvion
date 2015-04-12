#!/bin/env ruby
# encoding: utf-8

# Arbitrary-precision ints/floats/math, built right in the stdlib. ♥ Ruby
require 'bigdecimal'

module API
    class Dc
        def exec(command)
            _dc = DcCore.new

            # These hold some state for the parser. Register is set when parsing a
            # register command, fix and frac are set when parsing a number. Fix is
            # what's to the left of the decimal point, frac what’s to the right.
            # Numbers with more than one decimal point are ok; the latter points are
            # ignored.
            # FIXME: support negative numbers
            register = nil
            fix = nil
            frac = nil

            command.each_char do |c|
                if c =~ /[0-9]/ # TODO: support radix 11-16
                    if frac
                        # This is string concatenation, not addition.
                        frac += c
                    else
                        # This gets hit the first time we get a number, hence the initial
                        # “enabling” of number-parsing mode by setting fix to a string.
                        fix ||= ''
                        fix += c
                    end
                elsif c == '.'
                    # If this was `frac = ''`, “further” decimal points would erase the
                    # previously parsed out fractional parts, which might be unwanted.
                    frac ||= ''
                else
                    # If we’re still in number-parsing mode but we’re not hitting a number,
                    # we need to push whatever number we’ve got to the stack.
                    if fix
                        # If there’s no fractional part, we still need to have a value there
                        # so BigDecimal creates the value properly.
                        frac ||= '0'
                        _dc.push BigDecimal.new "#{fix}.#{frac}"

                        # Reset the state of the parser and carry on.
                        fix = nil
                        frac = nil
                    end

                    if register
                        # There are up to 256 registers in the original dc, keyed by the
                        # ascii value of a single character. We theoretically support Unicode,
                        # so we probably support a whole lot more registers.
                        address = c.ord
                        _dc.send "_#{register}".to_sym, address

                        # Reset the state of the parser and iterate forth.
                        register = nil
                    elsif %w(s l S L).include? c
                        # These are the four register commands. Set state and iterate forth.
                        register = c
                    elsif _dc.respond_to? "_#{c}"
                        _dc.send "_#{c}".to_sym
                    end
                end
            end

            _dc.result
        end
    end
end

class DcCore
    def initialize
        @stack = []
        @registers = []
        @result = []

        # TODO: support these
        @precision = 0
        @input_radix = 10
        @output_radix = 10
    end

    def push(n)
        @stack.push n
    end

    def result
        @result.join ''
    end

    # Arithmetic
    define_method '_+' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(a + b)
    end

    define_method '_-' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(b - a)
    end

    define_method '_*' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(a * b)
    end

    define_method '_/' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(b / a)
    end

    define_method '_%' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(b % a)
    end

    define_method '_~' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(b % a)
        @stack.push(b / a)
    end

    define_method '_^' do
        a = @stack.pop
        b = @stack.pop
        @stack.push(b**a)
    end

    define_method '_|' do
        a = @stack.pop
        b = @stack.pop
        c = @stack.pop
        @stack.push((c**b) % a)
    end

    def _v
        a = @stack.pop
        @stack.push a.sqrt @precision
    end

    # Output
    def _p
        @result.push @stack.last.to_s 'F'
        @result.push "\n"
    end

    def _n
        @result.push @stack.pop.to_s 'F'
    end

    def _P
        @result.push @stack.pop.chr 'UTF-8'
    end

    def _f
        @stack.each do |v|
            @result.push v.to_s 'F'
            @result.push "\n"
        end
    end

    # Stack control
    def _c
        @stack = []
    end

    def _d
        @stack.push @stack.last
    end

    def _r
        a = @stack.pop
        b = @stack.pop
        @stack.push a
        @stack.push b
    end

    # Registers
    def _s(r)
        @registers[r] ||= []
        @registers[r][0] = @stack.pop
    end

    def _l(r)
        @stack.push @registers[r].last
    end

    def _S(r)
        @registers[r] ||= []
        @registers[r].push @stack.pop
    end

    def _L(r)
        @stack.push @registers[r].pop
    end

    # Parameters
    def _i
        @input_radix = @stack.pop
    end

    def _o
        @output_radix = @stack.pop
    end

    def _k
        @precision = @stack.pop
    end

    def _I
        @stack.push @input_radix
    end

    def _O
        @stack.push @output_radix
    end

    def _K
        @stack.push @precision
    end

    # Status
    def _Z
        # Probably wrong, FIXME
        a = @stack.pop
        l = (a.fix.to_i.to_s.length + a.frac.to_i.to_s.length).to_s
        @stack.push BigDecimal.new l
    end

    def _X
        l = @stack.pop.frac.to_i.to_s.length.to_s
        @stack.push BigDecimal.new l
    end

    def _z
        l = @stack.length.to_s
        @stack.push BigDecimal.new l
    end
end
