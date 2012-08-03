require 'rubygems'
require 'google_calendar'
require 'yaml'

module EventCalendar
  class Calendar < Google::Calendar
    def initialize(args = {})
      calendar = args[:test] ? 'test' : 'name'
      attributes = {
        :username => settings['username'],
        :password => settings['password'],
        :app_url => settings['app_name'],
        :calendar => settings[calendar]
      }
      super(attributes)
    end
    
    def settings
      @settings ||= settings_from_yml['calendar']
    end
    
    def settings_from_yml
      path = File.join(File.dirname(__FILE__),'..','..', 'settings.yml')
      YAML.load_file(path)
    end
  end
end
