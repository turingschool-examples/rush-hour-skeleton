class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :user_agent
  belongs_to :referrer
  belongs_to :event_name
  belongs_to :ip

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :parameters, presence: true
  validates :url_id, presence: true
  validates :referrer_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    average("responded_in")
  end

  def self.max_response_time
    maximum("responded_in")
  end

  def self.min_response_time
    minimum("responded_in")

  end

  def self.counts_request_type_max
    group("request_type").count.first[1]
  end

  def self.most_frequent_request_type
    request_hash = group("request_type").count
    matching_requests =request_hash.find_all do |request_type, count|
      count == counts_request_type_max
    end
    matching_requests.map do |request_type, count|
      request_type.verb
    end.join(", ")
  end

end
