class PayloadRequest < ActiveRecord::Base

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :parameter
  belongs_to :event
  belongs_to :u_agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client

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

  def self.most_frequent_request_type
    joins(:request_type).group(:verb).order(count: :desc).count.first.first
  end

  def self.event_list_from_most_to_least
    joins(:event).group(:name).order(count: :desc).count
  end

  def self.urls_list_from_most_to_least_requested
    joins(:url).group(:address).order(count: :desc).count
  end
end
