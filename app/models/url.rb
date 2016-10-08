class Url < ActiveRecord::Base
  has_many :payload

  validates :root_url, presence: true
  validates :path, presence: true


  def self.max_response_time(id)
    Payload.where(url_id: id).maximum(:responded_in)
  end

  def self.min_response_time(id)
    Payload.where(url_id: id).minimum(:responded_in)
  end

  def self.response_times_desc(id)
    Payload.where(url_id: id).order(responded_in: :desc).map do |e|
      e.responded_in
    end
  end

  def self.average_response_time(id)
    Payload.where(url_id: id).average(:responded_in).to_f
  end

  def self.all_http_verbs(id)
    Payload.where(url_id: id).map do |e|
      RequestType.find(e.request_type_id).http_verb
    end.sort
  end

  def self.top_three_referrals(id)
    grouped_arr = Payload.where(url_id: id).group(:referred_by_id).count.sort_by{|k,v| v}.reverse
    mapped_arr = grouped_arr.each do |e|
      e[0] = ReferredBy.find(e[0]).root_url + ReferredBy.find(e[0]).path
    end
    mapped_arr.sort_by{|e| [-e.last, e.first]}.map do |url|
      url.first
    end[0..2]
  end

  def self.top_three_agents(id)
    grouped_arr = Payload.where(url_id: id).group(:agent_id).count.sort_by{|k,v| v}.reverse
    mapped_arr = grouped_arr.each do |e|
      e[0] = Agent.find(e[0]).browser + " " + Agent.find(e[0]).operating_system
    end
    mapped_arr.sort_by{|e| [-e.last, e.first]}.map do |agent|
      agent.first
    end[0..2]
  end


end
