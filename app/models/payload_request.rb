class PayloadRequest < ActiveRecord::Base
  belongs_to :request_type
  belongs_to :target_url
  belongs_to :referrer_url
  belongs_to :resolution
  belongs_to :u_agent
  belongs_to :ip

  validates :request_type_id,   presence: true
  validates :target_url_id,     presence: true
  validates :referrer_url_id,   presence: true
  validates :resolution_id,     presence: true
  validates :u_agent_id,        presence: true
  validates :ip_id,             presence: true
  validates :responded_in,      presence: true
  validates :requested_at,      presence: true

  def self.average_response_time
    average(:responded_in).to_f
  end

  def self.max_response_time
    maximum(:responded_in)
  end
  
  def self.min_response_time
    minimum(:responded_in)
  end

end
