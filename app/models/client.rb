class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :event_names, through: :payload_requests
  has_many :ips, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :user_agents, through: :payload_requests, :class_name => "PayloadUserAgent"

  has_many :requested_ats, through: :payload_requests
  has_many :responded_ins, through: :payload_requests
  has_many :parameters, through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true

  def counts_request_type_max
    payload_requests.group("request_type").count.first[1]
  end

  def most_frequent_request_type
    request_hash = payload_requests.group("request_type").count
    matching_requests = request_hash.find_all do |request_type, count|
      count == counts_request_type_max
    end
    matching_requests.map do |request_type, count|
      request_type.verb
    end
  end

  def order_urls_by_count
    payload_requests.group("url").count.to_a.map do |nested|
      nested[0].name
    end
  end
end
