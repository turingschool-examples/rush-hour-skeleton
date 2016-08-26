class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referred_bies, through: :payload_requests
  has_many :u_agents, through: :payload_requests

  validates :url, presence: true

  def maximum_response_time
    payload_requests.maximum("responded_in")
    # url.payload_requests.maximum("responded_in")
  end

  def minimum_response_time
    payload_requests.minimum("responded_in")
  end

  def response_times_by_order
    payload_requests.order(responded_in: :desc).pluck("responded_in")
  end

  def average_response_time
    payload_requests.average("responded_in")
  end

  def top_three_referred_bies
    referred_by_counts = referred_bies.group(:url).count
    raw_referred_bies = referred_by_counts.sort_by { |key, value| value }.reverse
    raw_referred_bies.map do |key, value|
      referred_bies.find_by(url: key)
    end[0..2]
  end

  def top_three_u_agents
    agent_counts = u_agents.group(:agent).count
    raw_agents = agent_counts.sort_by { |key, value| value }.reverse
    raw_agents.map do |key, value|
      u_agents.find_by(agent: key)
    end[0..2]
  end



#   url.referred_bies.group(:url).count
  # def top_three_referred_bies
  #   payload_requests.group('referred_b')
  # end



# may decide to create explicit url.request_types method (which is redundant)


end
