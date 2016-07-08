class SoftwareAgent < ActiveRecord::Base
  validates :message, presence: true
  has_many :payload_requests

  def self.all_browsers_used
    messages = SoftwareAgent.all.pluck(:message)
    user_agents = messages.map do |message|
      UserAgent.parse(message)
    end

    browsers = user_agents.map do |user_agent|
      user_agent.browser
    end
    return browsers
  end

  def self.all_os_used
    messages = SoftwareAgent.all.pluck(:message)
    user_agents = messages.map do |message|
      UserAgent.parse(message)
    end

    os = user_agents.map do |user_agent|
      user_agent.os
    end
    return os
  end

end
# require 'pry'; binding.pry
