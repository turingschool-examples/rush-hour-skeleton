module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source
    belongs_to :url
    belongs_to :user_agent
    belongs_to :resolution
    belongs_to :event_name

  end
end
