class PayloadRequest < ActiveRecord::Base
  has_many   :clients
  belongs_to :user_agent_b
  belongs_to :resolution
  belongs_to :url
  belongs_to :event
  belongs_to :ip
  belongs_to :referrer
  belongs_to :request

  validates :url_id,              presence: true
  validates :requested_at,     presence: true
  validates :responded_in,     presence: true
  validates :request_id,       presence: true
  validates :referrer_id,      presence: true
  validates :parameters,       presence: true
  validates :event_id,         presence: true
  validates :user_agent_b_id,    presence: true
  validates :resolution_id,    presence: true
  validates :ip_id,            presence: true
  # validates :shaq, uniquess: true
  # validates :id_client,        presence: true

  def self.average_response_time
    self.average(:responded_in).truncate
  end

  def self.top_request_types
    request_type_hash = self.group(:request_type).order('count_id DESC').count(:id)
    top_request = request_type_hash.first[0]
  end

  def self.url_range
    url_range_hash = self.group(:id_url).order('count_id DESC').count(:id)
    url_range_hash.keys
  end

  def self.all_http_verbs
    require 'pry'; binding.pry
    self.pluck("request_type").uniq
  end

end
