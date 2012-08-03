$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'rubygems'
require 'sinatra'
require 'erb'
#require_relative 'lib/triple_parser'


get '/' do
  erb :event
end



