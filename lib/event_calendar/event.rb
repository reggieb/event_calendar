require_relative 'calendar'

module EventCalendar
  class Event
    
    ATTRIBUTES = %w{title start_time end_time where content}

    attr_accessor *ATTRIBUTES
    attr_accessor :calendar_event_id
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
      load_attributes(args)
      @test = args[:test]
      @calendar_event_id = args[:calendar_event_id]
    end
    
    def save
      if calendar_event
        save_existing
      else
        create_new_event_in_calendar
      end
    end
    
    def delete
      if load_from_calendar
        @calendar_event.delete
      end
    end
    
    def load_from_calendar
      if calendar_event_id
        @calendar_event = calendar.find_or_create_event_by_id(calendar_event_id)
        load_attributes(calendar_event)
      end
    end
    
    private
    def load_attributes(source, target = self)
      ATTRIBUTES.each do |attr|
        if source.kind_of? Hash
           target.send("#{attr}=", source[attr.to_sym])
        else
          target.send("#{attr}=", source.send(attr))
        end
      end
    end
    
    def save_existing
      load_attributes(@calendar_event)
      calendar.save_event(@calendar_event)
    end
    
    def create_new_event_in_calendar
      @calendar_event = calendar.create_event do |e|
        load_attributes(self, e)
        end
      @calendar_event_id = @calendar_event.id
    end
    
  end
end
