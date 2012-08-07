require_relative 'calendar'

module EventCalendar
  class Event

    attr_accessor :title, :description, :start_at, :end_at, :where, :content, :calendar_event_id
    attr_reader :calendar_event
    
    def self.find(id, args = {})
      event = new(
        :test => args[:test],
        :calendar_event_id => id
      )
      event.load_from_calendar
      return event
    end

    def initialize(args = {})
      load(args)
    end
    
    def calendar
      Calendar.new(:test => @test)
    end
    
    def load(args)
      @title = args[:title]
      @start_at = args[:start_at]
      @end_at = args[:end_at]
      @content = args[:content]
      @where = args[:where]
      @test = args[:test]
      @calendar_event_id = args[:calendar_event_id]
    end
    
    def save
      if @calendar_event
        @calendar_event.title = @title
        @calendar_event.start_time = @start_at
        @calendar_event.end_time = @end_at
        @calendar_event.content = @content
        @calendar_event.where = @where
        calendar.save_event(@calendar_event)
      else
        @calendar_event = calendar.create_event do |e|
          e.title = @title
          e.start_time = @start_at
          e.end_time = @end_at
          e.content = @content
          e.where = @where
        end
        @calendar_event_id = @calendar_event.id
      end
      @calendar_event.content = "Hurrah!"
    end
    
    def delete
      if load_from_calendar
        @calendar_event.delete
      end
    end
    
    def load_from_calendar
      if calendar_event_id
        @calendar_event = calendar.find_or_create_event_by_id(calendar_event_id)
        @title = calendar_event.title
        @start_at = calendar_event.start_time
        @end_at = calendar_event.end_time
        @where = calendar_event.where
        @content = calendar_event.content
      end
    end
    
  end
end
