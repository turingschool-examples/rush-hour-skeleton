module TrafficSpy
  class Payload < ActiveRecord::Base
    # validates_presence_of :payload
    belongs_to :source

    validates_presence_of :url,
                          :requested_at,
                          :responded_in,
                          :referred_by,
                          :request_type,
                          :event_name,
                          :user_agent,
                          :resolution_width,
                          :resolution_height,
                          :ip,
                          :sha

    validates_uniqueness_of :sha

  end
end
