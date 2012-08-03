
module EventCalendar
  class Event

    attr_accessor :name, :description, :start_at, :end_at

    def initialize(args = {})
      @name = args[:name]
      @description = args[:description]
      @start_at = args[:start_at]
      @end_at = args[:end_at]

    end
    
  end
end
