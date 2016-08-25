class UAgent < ActiveRecord::Base
  has_many :payload_requests
  validates :browser, presence: true
  validates :browser, uniqueness: {scope: :operating_system}
  validates :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}

  def self.browser_breakdown
    breakdown("browser")
  end

  def self.os_breakdown
    breakdown("operating_system")
  end

  def self.breakdown(type)
    group_by_u_agent.to_a.reduce({}) do |result, grouping|
      u_agent = UAgent.find_by(:id => grouping[0]).send(type)
      result = incrament_browser_count(result, u_agent, grouping[1])
    end
  end

  def self.group_by_u_agent
    PayloadRequest.group('u_agent_id').count
  end

  private
  def self.incrament_browser_count(result, browser, count)
    result.has_key?(browser) ? result[browser] += count : result[browser] = count
    result
  end

end
