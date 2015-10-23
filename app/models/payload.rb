module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source

    validates_presence_of :url,
                          :requested_at,
                          :responded_in,
                          :referred_by,
                          :request_type,
                          :parameters,
                          :event_name,
                          :user_agent,
                          :resolution_height,
                          :resolution_width,
                          :ip

    validates_uniqueness_of :unique_hash
  end
end
