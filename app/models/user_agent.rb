class Agent < ActiveRecord::Base

  has_many :payloads

  validates :agent, presence: true

  def self.browser_breakdown(payloads)
    Agent.all.reduce({}) do |result, agent_row|
      count = payloads.pluck(:agent_id).count(agent_row.id)
      result[UserAgent.browser_name(agent_row.agent)] = count
      result
    end
  end

  def self.os_breakdown(payloads)
    Agent.all.reduce({}) do |result, agent_row|
      count = payloads.pluck(:agent_id).count(agent_row.id)
      result[UserAgent.os(agent_row.agent)] = count
      result
    end
  end
end
