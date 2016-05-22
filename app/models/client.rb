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

  def check_for_payloads
    if payload_requests.count > 0
      true
    else
      false
    end
  end

  def find_matching_payloads(event_name)
    event_name = EventName.find_by(name: event_name)
    payloads = payload_requests.where(event_name: event_name)
  end

  def matching_request_ats(event_name)
    find_matching_payloads(event_name).map do |payload|
      payload.requested_at
    end
  end

  def breakdown_by_hour(event_name)
    hour_hash = matching_request_ats(event_name).group_by do |requested_at|
      requested_at.hour
    end
    1.upto(24) do |i|
      if hour_hash.keys.include?(i) == false
        hour_hash[i] = []
      end
    end
    hour_hash.sort
  end

end
