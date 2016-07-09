class PayloadRequest < ActiveRecord::Base

  validates :url_id,               presence: true
  validates :requested_at,         presence: true
  validates :responded_in,         presence: true
  validates :referred_by_id,       presence: true
  validates :request_type_id,      presence: true
  validates :software_agent_id,    presence: true
  validates :ip_id,                presence: true
  validates :resolution_id,        presence: true
  validates :client_id,            presence: true
  validates :parameter_id,         presence: true

  belongs_to :url
  belongs_to :referrer, foreign_key: :referred_by_id
  belongs_to :request_type
  belongs_to :software_agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client
  belongs_to :parameter


  def self.most_frequent_type
    values = PayloadRequest.pluck(:request_type_id)
    id = values.group_by(&:itself).values.max_by(&:size).first
    RequestType.find(id).verb
  end

  def self.list_of_http_verbs_used
    values = PayloadRequest.pluck(:request_type_id)
    values.map do |type|
      RequestType.find(type).verb
    end
  end

  def referrer
    Referrer.find(self.referred_by_id)
  end

  def self.find_specific_url(url)
    id = Url.find_by_address(url).id
    payloads = PayloadRequest.where(url_id: id)
  end

  def self.find_max_response_by_url(url)
    payloads = find_specific_url(url)
    responses = payloads.map do |payload|
      payload.responded_in
    end
    responses.max
  end

  def self.find_min_response_by_url(url)
    payloads = find_specific_url(url)
    responses = payloads.map do |payload|
      payload.responded_in
    end
    responses.min
  end

  def self.find_average_response_time_by_url(url)
    payloads = find_specific_url(url)
    times = payloads.all.pluck(:responded_in)
    times.reduce(:+)/times.count
  end
end
