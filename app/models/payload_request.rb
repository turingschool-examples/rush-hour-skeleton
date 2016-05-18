class PayloadRequest < ActiveRecord::Base

  belongs_to :event
  belongs_to :ip
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :screen_size
  belongs_to :url
  belongs_to :user_agent_info

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :parameters, presence: true
  validates :event_id, presence: true
  validates :user_agent_info_id, presence: true
  validates :screen_size_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    self.average("responded_in").to_i
  end

  def self.max_response_time
    self.maximum("responded_in")
  end

  def self.min_response_time
    self.minimum("responded_in")
  end

  # def self.most_common_request_type
  #   self.
  #this ones a thinker

  def self.all_http_verbs
    self.uniq.pluck("request_type")
  end

  def self.list_urls_in_frequency
    self.group("url").count
  end
end
