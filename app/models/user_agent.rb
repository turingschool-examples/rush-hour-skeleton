class UserAgent < ActiveRecord::Base
  has_many :payload_requests
  belongs_to :client

  validates :browser, presence: true
  validates :os,      presence: true

  def self.all_web_browsers
    self.distinct.pluck(:browser)
  end

  def self.all_operating_systems
    self.distinct.pluck(:os)
  end
end

# client = Client.find_by(identifier: identifier)
#
# client.user_agents.all_web_browsers
#
# UserAgent.all_web_browsers
