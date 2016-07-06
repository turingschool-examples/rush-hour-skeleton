class PayloadRequest < ActiveRecord::Base
  validates :requested_at, :responded_in,
            :request_type, :user_agent,
            :resolution_width, :resolution_height,
            :ip, :url_id, presence: true

end
