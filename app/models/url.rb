class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :clients, through: :payload_requests
  has_many :responded_ins, through: :payload_requests

  validates :name, presence: true

  def associated_verbs
    request_types.pluck("verb")
  end

  def top_three_referrers
    # change referrer_id to referrer to get group objects
    referrer_id_count = payload_requests.group("referrer_id").count
    sorted_id = referrer_id_count.sort_by { |k, v| -v }.first(3)

    #binding.pry

    sorted_id.map do |id|
      Referrer.find(id[0])
    end
  end

  def top_three_user_agents
    user_agent_id_count = payload_requests.group("user_agent_id").count
    sorted_id = user_agent_id_count.sort_by { |k, v| -v }.first(3)

    sorted_id.map do |id|
      PayloadUserAgent.find(id[0])
    end
  end

  def max_response_time
    responded_ins.maximum("time")
  end

  def min_response_time
    responded_ins.minimum("time")
  end

  def response_times_longest_to_shortest
    responded_ins.order("time").reverse_order.pluck("time")
  end

  def average_response_time
    responded_ins.average("time").round
  end
end
