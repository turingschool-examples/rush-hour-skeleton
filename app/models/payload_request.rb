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

  def self.min_response_time
    minimum("responded_in")
  end

  def self.most_frequent_request_type
    most_freq_url_id = group("url_request_id")
                      .order('count(*) DESC')
                      .limit(1)
                      .pluck(:url_request_id)
                      .first
    UrlRequest.find(most_freq_url_id).request_type
  end
end
