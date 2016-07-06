class PayloadRequest < ActiveRecord::Base
  validates :url, :requested_at, :responded_in, :referred_by, :request_type, :user_agent, :resolution_width, :resolution_height, :ip, presence: true

end
