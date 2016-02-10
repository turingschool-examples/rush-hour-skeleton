class PayloadRequest < ActiveRecord::Base
  belongs_to :referrer
  belongs_to :url_request
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip_address

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :event_name, presence: true

  def self.average_response_time
    average("responded_in")
  end

  def self.max_response_time
    maximum("responded_in")
  end
end
