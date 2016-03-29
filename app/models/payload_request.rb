class PayloadRequest < ActiveRecord::Base

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :parameter
  belongs_to :event
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip

  validates :requested_at, presence: true
  validates :responded_in, presence: true

  def self.average_response_time
    average(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end
end
