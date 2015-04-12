#!/bin/env ruby
# encoding: utf-8

# Arbitrary-precision ints/floats/math, built right in the stdlib. ♥ Ruby
require 'bigdecimal'
require 'api'

class Answer
  def dc
    # A bare split does so on whitespace, which we don’t care about, so after
    # we eliminate the prefix we can recombine using spaces to simplify
    # further parsing.
    command = @message.split
    command.shift # get rid of 'dc' prefix
    command = command.join ' '

    # The bare split above even gets rid of extra whitespace for us, so even if
    # someone calls `"nouvion dc           "` (note the extra stuff), this
    # will still catch on.
    if command.length == 0 or command =~ /^help/
      return '
A partial implementation of GNU’s `dc` reverse-polish arbitrary-precision
stack-based command-line calculator. Doesn’t support strings, macros,
negative number inputs, nor the “Misc” instructions.

*Quick Guide*: Use spaces to separate adjacent numbers, `p` to print the top of
the stack, `f` to print the whole stack.  `+ - / * ^ %` work as expected, `v`
is sqrt and `|` is exponential modulo. `r` to reverse the two numbers at the
top of the stack, `d` to duplicate the top one, `c` to clear the stack.

*Example*: Calculate the volume of a cone (radius: 493, height: 1937):
`3.14159 493 1937 3/rd***p` gives us a uselessly precise
`493005438.80722333333358785343597`.
'.gsub("\n\n", '§').gsub("\n", '').gsub('§', "\n\n")
      # ^ Remove all linebreaks except those in paragraphs. Ok, there's probably an
      # easier and more efficient way to do it but I can't think just now. FIXME
    end

    dc = API::Dc.new

    return dc.exec(command)
  end
end

