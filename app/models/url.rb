class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :sources, through: :payload_requests
  validates :address, presence: true
  validates :address, uniqueness: true

  def self.most_to_least_requested_url
    group_by_url.to_a.map do |frequency_url_id|
      Url.find_by(:id => frequency_url_id[1]).address
    end
  end

  def self.group_by_url
    PayloadRequest.group('url_id').order("url_id desc").count
  end

  def top_3_sources
    sources = []
    source_id_counts = payload_requests.order("source_id").group("source_id").count
    source_id_counts.to_a.sort_by do |source_count|
      source_count[1]
    end.reverse[0..2].each do |source_count|
      sources << Source.find_by(:id => source_count[0])
    end
    sources
  end

  def top_3_u_agents
    u_agents = []
    u_agent_id_counts = payload_requests.order("u_agent_id").group("u_agent_id").count
    u_agent_id_counts.to_a.sort_by do |u_agent_count|
      u_agent_count[1]
    end.reverse[0..2].each do |u_agent_count|
      u_agents << UAgent.find_by(:id => u_agent_count[0])
    end
    u_agents
  end

  def verbs
    request_types
  end

end
