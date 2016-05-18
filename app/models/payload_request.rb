class PayloadRequest < ActiveRecord::Base
  belongs_to :user_agent_b
  belongs_to :resolution
  belongs_to :url
  belongs_to :client
  belongs_to :events
  belongs_to :ip
  belongs_to :referrer
  belongs_to :request

  validates :id_url,           presence: true
  validates :requested_at,     presence: true
  validates :responded_in,     presence: true
  validates :id_request,       presence: true
  validates :id_referrer,      presence: true
  validates :parameters,       presence: true
  validates :id_event,         presence: true
  validates :id_useragent,     presence: true
  validates :id_resolution,    presence: true
  validates :id_ip,            presence: true
  validates :id_client,        presence: true

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
