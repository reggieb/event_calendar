$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'rubygems'
require 'sinatra'
require 'erb'
require_relative 'lib/event_calendar'

module EventCalendar

  get '/' do
    erb :event
  end

  post '/' do
    @event = Event.new(params)
    erb :event
  end

end




