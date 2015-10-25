require 'json'
require 'digest'
require 'uri'
require './app/controllers/server.rb'


class UrlData
  def self.find_min_max(payload, url)
    counts = Hash.new 0
    payload.find_each do |payload|
      counts[payload.url_id] += 1
    end
    max_min_hash = counts.map { |k, v| {url.find(url_id = k).url => v}}
  end

  def self.find_browser_data(payload, agent)
    payload.find_each do |payload|
      @browser_array ||= []
      @browser_array << UserAgent.parse(agent.find(payload.agent_id).agent).browser
    end
    browser_data = @browser_array.uniq!
  end

  def self.breakdown_os(payload, agent)
    payload.find_each do |payload|
      @os_breakdown ||= []
      @os_breakdown << UserAgent.parse(agent.find(payload.agent_id).agent).os
    end
    os_hash = @os_breakdown.uniq!
  end

  def self.find_resolution(payload)
    payload.find_each do |payload|
      @resolution_array ||= []
      @resolution_array << "#{payload.resolution_width} x #{payload.resolution_height}"
    end
    resolution = @resolution_array.uniq!
  end

  def self.find_response(payload)
    payload.find_each do |payload|
      @response ||= []
      @response << payload.responded_in.to_i
    end
    @response_time = @response.sort!.reverse!
  end

  def self.find_http_verbs(payload)
    payload.find_each do |payload|
      @http_array ||= []
      @http_array << payload.request_type
    end
    @http_verbs = @http_array.uniq!

  end

  def self.find_referrals(payload)
    @referral_hash = Hash.new 0
    payload.find_each do |payload|
      @referral_hash[payload.referred_by] += 1
    end
    @referral = @referral_hash.max(3)
  end

  def self.find_agents(payload, agent)
    @agents = Hash.new 0
    payload.find_each do |payload|
      @agents[payload.agent_id] += 1
    end
    @top_agents = @agents.map { |k, v| {agent.find(agent_id = k).agent => v}}
  end
end
