class Payload < ActiveRecord::Base

  belongs_to :client


  def self.url_requests
    group(:path).order('count_id desc').count('id')
  end

  def self.url_response_times
    group(:path).order('average_responded_in desc').average('responded_in')
  end

  def self.url_hyperlinks
    pluck(:path).uniq
  end

  def self.show_response_times(path_requested)
    longest = Payload.where(path: path_requested).maximum(:responded_in)
    shortest = Payload.where(path: path_requested).minimum(:responded_in)
    average = Payload.where(path: path_requested).average(:responded_in)
    {longest: longest, shortest: shortest, average: average }
  end

  def self.show_request_types
    pluck(:request_type).uniq
  end

  def self.top_referrers
    group(:referred_by).order('count_id desc').limit(3).count('id')
  end

  def self.top_user_agents
    group(:web_browser).order('count_id desc').limit(3).count('id')
  end

  def self.event_requests
    group(:event_name).order('count_id desc').count('id')
  end

  def self.event_hyperlinks
    pluck(:event_name).uniq
  end

  def self.hour_by_hour_breakdown
    pluck(:requested_at).map { |t| t.to_datetime.hour }.sort
  end


end
