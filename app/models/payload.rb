module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source
    belongs_to :url
    belongs_to :browser
    belongs_to :event_name
    belongs_to :operating_system
    belongs_to :screen_resolution

  end
end
