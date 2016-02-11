require 'pry'

class PayloadRequest < ActiveRecord::Base
  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referrer_id, presence: true
  validates :request_id, presence: true
  validates :event_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  belongs_to :referrer
  belongs_to :request
  belongs_to :event
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :url
  belongs_to :ip

  def self.average_response_time
    PayloadRequest.average(:responded_in).round(2)
  end

  def self.find_max_response_time
    PayloadRequest.maximum(:responded_in)
  end

  def self.find_min_response_time
    PayloadRequest.minimum(:responded_in)
  end

  def self.find_most_frequent_request_type
    id = PayloadRequest.group(:request_id).order('count(*)').limit(2).pluck(:request_id).reverse.first
    r = Request.find(id)
    r.verb
  end

  def self.find_all_http_verbs
    request_ids = PayloadRequest.group(:request_id).order('count(*)').limit(4).pluck(:request_id)
    request_ids.map { |id| Request.find(id).verb }
  end

  def self.return_ordered_list_of_urls
    url_ids = PayloadRequest.group(:url_id).order('count(*)').limit(4).pluck(:url_id).reverse
    url_ids.map { |id| Url.find(id).address }
  end

end
