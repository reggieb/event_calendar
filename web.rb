$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'rubygems'
require 'sinatra'
require 'erb'
require_relative 'lib/event_calendar'

module EventCalendar

  get '/' do
    @event = Event.new
    @events = @event.calendar.events
    @events = [@events] unless @events.kind_of? Array
    erb :event
  end

  post '/' do
    @event = Event.new(params)
    @event.save
    @events = @event.calendar.events
    @events = [@events] unless @events.kind_of? Array
    erb :event
  end
  
  get '/event' do
    @event = Event.find(params[:id])
    erb :event
  end
  
  post '/event' do
    @event = Event.find(params[:id])
    @event.load(params)
    @event.save
    @events = @event.calendar.events
    @events = [@events] unless @events.kind_of? Array
    erb :event
  end
 
end




