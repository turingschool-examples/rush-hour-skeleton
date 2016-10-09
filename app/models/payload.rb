class Payload < ActiveRecord::Base

  belongs_to :request_type
  belongs_to :url
  belongs_to :referred_by
  belongs_to :event_name
  belongs_to :agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    Payload.average(:responded_in)
  end

  def self.max_response_time
    Payload.maximum(:responded_in)
  end

  def self.min_response_time
    Payload.minimum(:responded_in)
  end

  def self.most_frequent(column)
    column_values = Payload.pluck("#{column.to_s}_id".to_sym)
    id_occurance = column_values.reduce({}) do |r, id|
      r[id] = column_values.count(id)
      r
    end
    #TODO MAKE DYNAMIC
    RequestType.find(id_occurance.max_by { |k, v| v }[0]).send(column)
  end

  def self.all_http_verbs
    Payload.pluck(:request_type_id).uniq.reduce([]) do |r, id|
      r << RequestType.find(id).request_type
      r
    end
  end

  def self.most_to_least_requested
    order = Payload.order('url_id DESC')
    order.reduce([]) do |r, obj|
      r << obj.url.url
      r
    end.uniq
  end

  def self.browser_breakdown
    Payload.pluck(:agent_id).reduce({}) do |r, id|
      r[UserAgent.browser_name(Agent.find(id).agent)] = Payload.pluck(:agent_id).count(id)
      r
    end
  end

  def self.os_breakdown
    Payload.pluck(:agent_id).reduce({}) do |r, id|
      r[UserAgent.os(Agent.find(id).agent)] = Payload.pluck(:agent_id).count(id)
      r
    end
  end

  def self.resolution_breakdown
    Payload.pluck(:resolution_id).reduce({}) do |r, id|
      r["#{(Resolution.find(id).resolution_width)}" + " x " + "#{(Resolution.find(id).resolution_height)}"] = Payload.pluck(:resolution_id).count(id)
      r
    end
  end

  def self.max_response_time_by_url(input_url)
    Payload.pluck(:responded_in, :url_id).sort.reverse.detect do |time_url_id|
      Url.find(time_url_id[1]).url == input_url
    end[0]
  end

  def self.min_response_time_by_url(input_url)
    Payload.pluck(:responded_in, :url_id).sort.detect do |time_url_id|
      Url.find(time_url_id[1]).url == input_url
    end[0]
  end

  def self.all_response_times_by_url(input_url)
    Payload.pluck(:responded_in, :url_id).sort.reverse.select do |time_url_id|
      Url.find(time_url_id[1]).url == input_url
    end.reduce([]) do |r, time_url_id|
      r << time_url_id[0]
      r
    end
  end

  def self.average_response_time_by_url(input_url)
    all_response_times = Payload.all_response_times_by_url(input_url)
    all_response_times.reduce(:+) / all_response_times.count
  end

  def self.http_verbs_by_url(input_url)
    Payload.pluck(:request_type_id, :url_id).reduce([]) do |r, type_url|
      r << RequestType.find(type_url[0]).request_type if Url.find(type_url[1]).url == input_url
      r
    end
  end
  
  def self.three_most_popular_referrers(input_url)
    Payload.pluck(:referred_by_id, :url_id).reduce({}) do |r, referral_url|
      r[ReferredBy.find(referral_url[0]).referred_by] = (Payload.pluck(:referred_by_id)).count(referral_url[0]) if  Url.find(referral_url[1]).url == input_url      
      r
    end.sort_by { |k, v| v }.reverse.first(3)
  end

  def self.three_most_popular_user_agents(input_url)
    result = Payload.pluck(:agent_id, :url_id).reduce({}) do |r, agent_type|
      r[Agent.find(agent_type[0]).agent] = (Payload.pluck(:agent_id)).count(agent_type[0]) if Url.find(agent_type[1]).url == input_url
      r  
    end
    
    sorted = result.sort_by { |k, v| v }.reverse.first(3)
    
    sorted.map do |ua|
      [UserAgent.os(ua.to_s), UserAgent.browser_name(ua.to_s).to_s]
    end
  end
end
