class PayloadRequest < ActiveRecord::Base
  validates :url, :requested_at, :responded_in, :referred_by, :user_agent, :resolution_width, :resolution_height, :ip, :request_type_id, presence: true

end
