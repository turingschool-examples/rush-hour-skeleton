class PayloadRequest < ActiveRecord::Base

  validates :url_id,               presence: true
  validates :requested_at,         presence: true
  validates :responded_in,         presence: true
  validates :referred_by_id,       presence: true
  validates :request_type_id,      presence: true
  validates :software_agent_id,    presence: true
  validates :ip_id,                presence: true
  validates :resolution_id,        presence: true

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :software_agent
  belongs_to :resolution
  belongs_to :ip

  def referrer
    Referrer.find(self.referred_by_id)
  end

  def self.find_max_response_by_url(url)
    id = Url.find_by_address(url).id
    payloads = PayloadRequest.where(url_id: id)
    responses = payloads.map do |payload|
      payload.responded_in
    end
    responses.max
  end

  def self.find_min_response_by_url(url)
    id = Url.find_by_address(url).id
    payloads = PayloadRequest.where(url_id: id)
    responses = payloads.map do |payload|
      payload.responded_in
    end
    responses.min
  end
end
