class PayloadRequest < ActiveRecord::Base

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :parameter
  belongs_to :event
  belongs_to :u_agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client

  validates :requested_at, presence: true
  validates :responded_in, presence: true

  def self.average_response_time
    average(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.most_frequent_request_type
    joins(:request_type).group(:verb).order(count: :desc).count.first.first
  end

  def self.event_list_from_most_to_least
    joins(:event).group(:name).order(count: :desc).count
  end

  def self.urls_list_from_most_to_least_requested
    joins(:url).group(:address).order(count: :desc).count
  end

  def self.all_response_time_from_most_to_least
    pluck(:responded_in).sort.reverse
  end

  def self.list_all_verbs
    joins(:request_type).pluck(:verb).uniq
  end

  def self.list_top_three_referrers
    joins(:referrer).group(:address).order(count: :desc).count.keys.take(3)
  end

  def self.list_top_three_u_agents
    joins(:u_agent).group(:browser, :platform).order(count: :desc).count.keys.take(3)
  end
end
