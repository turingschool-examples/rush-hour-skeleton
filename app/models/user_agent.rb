class UserAgent < ActiveRecord::Base
  has_many :payload_requests
  belongs_to :client

  validates :browser, presence: true
  validates :os,      presence: true

  def self.all_web_browsers(client_id)

  end

  def all_operating_systems
    payload_requests.distinct.pluck(:os)
  end
end

# client = Client.find_by(identifier: identifier)
#
# client.user_agents.all_web_browsers
#
# UserAgent.all_web_browsers
