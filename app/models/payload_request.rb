class PayloadRequest < ActiveRecord::Base
  has_one :user_agent
  has_one :resolution

  validates :url,           presence: true
  validates :requested_at,  presence: true
  validates :responded_in,  presence: true
  validates :request_type,  presence: true
  validates :referred_by,   presence: true
  validates :parameters,    presence: true
  validates :event_name,    presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip,            presence: true

  def self.average_response_time
    self.average("responded_in").truncate
  end

  def self.top_request_types
    request_type_hash = self.group(:request_type).order('count_id DESC').count(:id)
    top_request = request_type_hash.first[0]
  end

  def self.url_range
    url_range_hash = self.group(:url).order('count_id DESC').count(:id)
    url_range_hash.keys
  end

  def self.all_http_verbs
    self.pluck("request_type").uniq
  end

end
