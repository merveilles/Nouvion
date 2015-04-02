#!/bin/env ruby
# encoding: utf-8

require 'bigdecimal'

class Answer
  def dc
    cmd = @message.split
    cmd.pop # get rid of 'dc' prefix
    cmd = cmd.join ' '

    _dc = Dc.new
    rcmd = nil
    fix = nil
    frac = nil
    cmd.each_char do |c|
      if c =~ /[0-9]/ # TODO: support radix 11-16
        if frac
          frac += c
        else
          fix ||= ''
          fix += c
        end
      elsif c == '.'
        frac ||= ''
      else
        if fix
          frac ||= '0'
          _dc.push BigDecimal.new "#{fix}.#{frac}"
          fix = nil
          frac = nil
        end

        if rcmd
          _dc.send "_#{rcmd}".to_sym, c[0].ord
          rcmd = nil
        elsif %w[s l S L].include? c
          rcmd = c
        elsif _dc.methods.grep(/^_/).map{|m|m.to_s}.include? "_#{c}"
          _dc.send "_#{c}".to_sym
        end
      end
    end

    {'text' => _dc.result}
  end
end

# https://gist.github.com/passcod/242bf44d78f7d99dccfc
class Dc
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
    @stack.push(b / a)
    @stack.push(b % a)
  end
  define_method '_^' do
    a = @stack.pop
    b = @stack.pop
    @stack.push(b ** a)
  end

  define_method '_|' do
    a = @stack.pop
    b = @stack.pop
    c = @stack.pop
    @stack.push((c ** b) % a)
  end

  def _v
    a = @stack.pop
    @stack.push(Math.sqrt a)
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
    # TODO
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
    @stack.push(a.fix.to_i.to_s.length + a.frac.to_i.to_s.length)
  end

  def _X
    @stack.push @stack.pop.frac.to_i.to_s.length
  end

  def _z
    @stack.push @stack.length
  end
end
