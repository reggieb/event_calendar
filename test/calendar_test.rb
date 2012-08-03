$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'event_calendar/calendar'
require 'google_calendar'

module EventCalendar
  class CalendarTest < Test::Unit::TestCase
    def test_initiation
      calendar = Calendar.new
      assert(calendar.kind_of? Google::Calendar)
      assert_equal(calendar.settings['name'], calendar.calendar)
    end
    
    def test_initiation_for_test
      calendar = Calendar.new(:test => true)
      assert(calendar.kind_of? Google::Calendar)
      assert_equal(calendar.settings['test'], calendar.calendar)
    end
  end
end
