class Payload < ActiveRecord::Base
  validates  :responded_in, presence: true
  validates  :requested_at, presence: true
  validates  :url_id, presence: true
  validates  :referral_id, presence: true
  validates  :request_id, presence: true
  validates  :event_id, presence: true
  validates  :user_agent_stat_id, presence: true
  validates  :resolution_id, presence: true
  validates  :visitor_id, presence: true

  belongs_to :url
  belongs_to :referral
  belongs_to :request
  belongs_to :event
  belongs_to :visitor
  belongs_to :resolution
  belongs_to :user_agent_stat
  belongs_to :client

  def self.average_response_time
    average("responded_in")
  end

  def self.max_response_time
    maximum("responded_in")
  end

  def self.min_response_time
    minimum("responded_in")
  end

  def self.all_response_times
    pluck("responded_in").sort.reverse
  end


end
