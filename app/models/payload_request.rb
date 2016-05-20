class PayloadRequest < ActiveRecord::Base
  has_many   :clients
  belongs_to :user_agent_b
  belongs_to :resolution
  belongs_to :url
  belongs_to :event
  belongs_to :ip
  belongs_to :referrer
  belongs_to :request

  validates :url_id,           presence: true
  validates :requested_at,     presence: true
  validates :responded_in,     presence: true
  validates :request_id,       presence: true
  validates :referrer_id,      presence: true
  validates :parameters,       presence: true
  validates :event_id,         presence: true
  validates :user_agent_b_id,  presence: true
  validates :resolution_id,    presence: true
  validates :ip_id,            presence: true
  # validates :shaq, uniquess: true
  # validates :id_client,        presence: true

  def self.average_response_time
    self.average(:responded_in).truncate
  end

  def self.top_request_types
    ordered_hash = includes(:request).group(:verb).order('count_id DESC')
    top_requests = ordered_hash.count('id').keys
    # require 'pry';binding.pry
  end

  def self.url_most_requested_to_least
    count_hash = includes(:url).group(:address).order('count_id DESC')
    ordered_hash= count_hash.count('id').keys
  end

  def self.all_http_verbs
    self.includes(:request).pluck(:verb).uniq
  end

  def self.max_response_time
    self.maximum(:responded_in)
  end

  def self.min_response_time
    self.minimum(:responded_in)
  end

  def self.event_most_received_to_least
    self.order('event_id DESC').includes(:event).pluck(:name).uniq
    #self.pluck("request_type").uniq
  end

end
