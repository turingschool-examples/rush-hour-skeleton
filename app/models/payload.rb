module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source
    belongs_to :url
    belongs_to :browser
    belongs_to :resolution
    belongs_to :event_name
    belongs_to :operating_system

  end
end
