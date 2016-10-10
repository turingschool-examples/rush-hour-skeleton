class Url < ActiveRecord::Base
  has_many :payloads

  validates :root_url, presence: true
  validates :path, presence: true


  def max_response_time
    payloads.maximum(:responded_in)
  end

  def min_response_time
    payloads.minimum(:responded_in)
  end

  def response_times_desc
    payloads.order(responded_in: :desc).map do |e|
      e.responded_in
    end
  end

  def average_response_time
    payloads.average(:responded_in).to_f
  end

  def all_http_verbs
    payloads.map do |e|
      RequestType.find(e.request_type_id).http_verb
    end.sort
  end

  def top_three_referrals
    grouped_arr = payloads(url_id: id).group(:referred_by_id).count.sort_by{|k,v| v}.reverse
    mapped_arr = grouped_arr.each do |e|
      e[0] = ReferredBy.find(e[0]).root_url + ReferredBy.find(e[0]).path
    end
    mapped_arr.sort_by{|e| [-e.last, e.first]}.map do |url|
      url.first
    end[0..2]
  end

  def top_three_agents
    grouped_arr = payloads.group(:agent_id).count.sort_by{|k,v| v}.reverse
    mapped_arr = grouped_arr.each do |e|
      e[0] = Agent.find(e[0]).browser + " " + Agent.find(e[0]).operating_system
    end
    mapped_arr.sort_by{|e| [-e.last, e.first]}.map do |agent|
      agent.first
    end[0..2]
  end


end
