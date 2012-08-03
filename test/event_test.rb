
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'event_calendar/event'

module EventCalendar
  class EventTest < Test::Unit::TestCase
    
    def setup
      @title = 'A Happening'
      @description = 'Something has happened'
      @start_at = Time.now - hours
      @end_at = Time.now + hours
      @event = Event.new(
        :title => @title,
        :description => @description,
        :start_at => @start_at,
        :end_at => @end_at,
        :test => true
      )
    end
    
    def teardown
      events_in_calendar.delete if events_in_calendar
    end
    
    def test_calendar
      assert(@event.calendar.kind_of? Google::Calendar)
      assert_equal('EventCalendarTest', @event.calendar.calendar)
    end
    
    def test_save
      assert_nil(events_in_calendar, "There should be no events")
      @event.save
      event = events_in_calendar
      assert_equal(@title, event.title)
    end
    
    def test_find
      test_save
      event = Event.find(@event.calendar_event_id, :test => true)
      assert_equal(@title, event.title)
    end
    
    def test_delete
      test_save
      @event.delete
      assert_nil(events_in_calendar, "There should be no events")
    end
    
    
    private
    def hours(number = 1)
      60 * 60 * number
    end
    
    def events_in_calendar
      two_hours_ago = Time.now - hours(2)
      two_hours_from_now = Time.now + hours(2)
      
      @event.calendar.find_events_in_range(
        two_hours_ago,
        two_hours_from_now
      )
    end
  end
end
