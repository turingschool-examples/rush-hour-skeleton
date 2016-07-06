class PayloadRequest < ActiveRecord::Base
  validates :url, :requested_at, :responded_in,
            :request_type, :user_agent,
            :resolution_width, :resolution_height, :ip,
            presence: true

end
