$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'rubygems'
require 'sinatra'
require 'erb'
require_relative 'lib/event_calendar'

module EventCalendar
  
  helpers do
    def get_events
      @events = @event.calendar.events
      @events = [@events] unless @events.kind_of? Array
      @events.compact!
    end
  end
  
  before '/event' do
    @event = Event.find(params[:id])
  end
  
  get '/' do
    @event = Event.new
    get_events
    erb :event
  end

  post '/' do
    @event = Event.new(params)
    @event.save
    get_events
    erb :event
  end
  
  get '/event' do
    @action = 'event'
    erb :event
  end
  
  post '/event' do
    @event.load(params)
    @event.save
    get_events
    @action = 'event'
    erb :event
  end
  
  post '/event/delete' do
    event = Event.find(params[:id])
    event.delete
    @event = Event.new
    get_events
    erb :event
  end
 
end




