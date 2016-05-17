class PayloadRequest < ActiveRecord::Base
  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :parameters_id, presence: true
  validates :event_name, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    self.average("responded_in").to_i
  end

  def self.max_response_time
    self.maximum("responded_in")
  end

  def self.min_response_time
    self.minimum("responded_in")
  end

  def self.most_common_request_type
    self.
end
