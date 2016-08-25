class PayloadRequest < ActiveRecord::Base
  belongs_to :request_types
  belongs_to :url
  validates :requested_at, :responded_in, :resolution_id, :user_agent_id, :referral_id, :ip_id, :request_type_id, :url_id, presence: true

  def self.average_response_time
    average('responded_in')
  end

  def self.max_response_time
    maximum('responded_in')
  end

  def self.min_response_time
    minimum('responded_in')
  end

end
