class PayloadRequest < ActiveRecord::Base
  belongs_to :referrer
  belongs_to :url_request
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip_address
  belongs_to :verb
  belongs_to :client

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :event_name,   presence: true

  validates_uniqueness_of :requested_at, scope: [ :responded_in, :event_name,
                                                  :referrer_id, :url_request_id,
                                                  :user_agent_id, :resolution_id,
                                                  :ip_address_id, :verb_id,
                                                  :client_id ]

  def self.average_response_time
    average("responded_in")
  end

  def self.max_response_time
    maximum("responded_in")
  end

  def self.min_response_time
    minimum("responded_in")
  end

  def self.most_frequent_request_type
    verb_id = group(:verb_id).order('count(*) DESC')
                                      .pluck(:verb_id)
                                      .first

    Verb.find(verb_id).request_type
  end

  def self.most_frequent_urls
    most_freq_url_ids = group("url_request_id")
                      .order('count(*) DESC')
                      .pluck(:url_request_id)

    most_freq_url_ids.map { |id| UrlRequest.find(id).url }
  end

  def self.event_name_breakdown
    group(:event_name).order('count(*) DESC').pluck(:event_name)
  end
end
