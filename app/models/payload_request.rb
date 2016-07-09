class PayloadRequest < ActiveRecord::Base
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :url_id, presence: true
  validates :referral_id, presence: true
  validates :request_type_id, presence: true
  validates :user_agent_device_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
  validates :sha, presence: true

  belongs_to :url
  belongs_to :referral
  belongs_to :request_type
  belongs_to :user_agent_device
  belongs_to :resolution
  belongs_to :ip

  def self.average_response_time
    average(:responded_in).to_i
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end
end
