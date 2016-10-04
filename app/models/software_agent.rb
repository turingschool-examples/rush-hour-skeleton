class SoftwareAgent < ActiveRecord::Base
  validates :os,         presence: true
  validates :browser,    presence: true
  validates :os,         uniqueness: true
  validates :browser,    uniqueness: true

  has_many :payload_requests
  has_many :clients, through: :payload_requests

  def self.web_browser_breakdown
    user_agent_id = PayloadRequest.distinct.pluck(:software_agent_id)
    user_agent_id.map do |id|
      SoftwareAgent.find(id).browser
    end
  end

  def self.web_platform_breakdown
    software_agent_id = PayloadRequest.distinct.pluck(:software_agent_id)
    software_agent_id.map do |id|
      SoftwareAgent.find(id).os
    end
  end
end
