module TrafficSpy  
  class Payload < ActiveRecord::Base
    belongs_to :source
    belongs_to :url
    belongs_to :user_agent

    validates :requested_at, presence: true
    validates :responded_in, presence: true
    validates :ip, uniqueness: { scope: :requested_at,
      message: "Can't send multiple payloads" }
                          # :requested_at,
                          # :responded_in,
                          # :referred_by,
                          # :request_type,
                          # :parameters,
                          # :event_name,
                          # :user_agent,
                          # :resolution_width,
                          # :resolution_height,
                          # :ip
  end
end