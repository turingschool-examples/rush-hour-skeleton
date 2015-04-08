class Payload < ActiveRecord::Base
  belongs_to :source

  validates :url, presence: true
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