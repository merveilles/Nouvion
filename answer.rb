#!/bin/env ruby
# encoding: utf-8

class Answer

  def initialize(moduleName,methodName,username,message)
    @username = username
    @message = message
    @username = username
    @message = message
  end

  def text
    return Hash["text" => "hello there"]
  end

  def hello
    return Hash["text" => "Hello #{@username}, nice to see you."]
  end

  def xoka
    return Hash["text" => "Xoka #{@username}, nice to see you."]
  end

  def sorry
    return Hash["text" => "Don't worry about it *#{@username}*."]
  end

end