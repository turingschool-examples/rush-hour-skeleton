class PayloadRequest < ActiveRecord::Base
  # validates :requested_at, :responded_in, :url_id, :referral_id, :request_type_id, :user_agent_device_id, :resolution_id, :ip_id, presence: true
  belongs_to :url
  belongs_to :referral
  belongs_to :request_type
  belongs_to :user_agent_device
  belongs_to :resolution
  belongs_to :ip

  def self.average_response_time
    average(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end
end
