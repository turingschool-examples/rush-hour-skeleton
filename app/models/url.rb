class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :clients, through: :payload_requests

  validates :name, presence: true

  def associated_verbs
    request_types.pluck("verb")
  end

  def top_three_referrers
    referrer_id_count = payload_requests.group("referrer_id").count
    sorted_id = referrer_id_count.sort_by { |k, v| -v }.first(3)

    sorted_id.map do |id|
      Referrer.find(id[0])
    end
  end

  def top_three_user_agents
    user_agent_id_count = payload_requests.group("user_agent_id").count
    sorted_id = user_agent_id_count.sort_by { |k, v| -v }.first(3)

    sorted_id.map do |id|
      UserAgent.find(id[0])
    end
  end

  def max_response_time
    payload_requests.maximum("responded_in")
  end

  def min_response_time
    payload_requests.minimum("responded_in")
  end

  def response_times_longest_to_shortest
    payload_requests.order("responded_in").reverse_order.pluck("responded_in")
  end

  def average_response_time
    payload_requests.average("responded_in").round
  end
end
