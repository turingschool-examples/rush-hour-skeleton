class Url < ActiveRecord::Base
  has_many :payloads

  def self.longest_response_time(webpage)
    Url.find_by(address: webpage).payloads.maximum(:responded_in)
  end

  def self.shortest_response_time(webpage)
    Url.find_by(address: webpage).payloads.minimum(:responded_in)
  end

  def self.average_response_time(webpage)
    Url.find_by(address: webpage).payloads.average(:responded_in)
  end

  def self.make_lines_readable(lines)
    if lines.uniq.length > 1
       lines.join(" / ")
    else
       lines.uniq[0]
    end
  end

  def self.request_types(webpage)
    all_payloads = Url.find_by(address: webpage).payloads

    requests = all_payloads.map do |payload|
      Request.find(payload.request_id).request_type
    end

    make_lines_readable(requests)
  end

  def self.popular_referrers(webpage)
    referrals = Url.find_by(address: webpage).payloads.map do |payload|
      Referral.find(payload.referral_id).url
    end

    most_popular = (referrals.group_by {|i| i}).sort.reverse.flatten.uniq.first
    # binding.pry
    #
    # popularity_by_num = most_popular.each_with_index do |referrer, index|
    #   (index + 1) + ". " + referrer
    # end
    #
    # make_lines_readable(popularity_by_num)
  end

  def self.popular_user_agent_browser(webpage)
      user_agents = Url.find_by(address: webpage).payloads.map do |payload|
      Agent.find(payload.agent_id).browser
    end

    most_popular = (user_agents.group_by {|i| i}).sort.reverse.flatten.uniq.first
  end

  def self.popular_user_agent_platform(webpage)
    user_agents = Url.find_by(address: webpage).payloads.map do |payload|
      Agent.find(payload.agent_id).platform
    end

    most_popular = (user_agents.group_by {|i| i}).sort.reverse.flatten.uniq.first
  end
end
