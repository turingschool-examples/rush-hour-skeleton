class PayloadRequest < ActiveRecord::Base

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referrer_url_id, presence: true
  validates :request_type_id, presence: true
  validates :parameters, presence: true
  validates :event_name_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    average(:responded_in).to_i
  end

end
