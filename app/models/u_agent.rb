require 'useragent'

class UAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :agent, presence: true, uniqueness: true

# def self.all_u_agents
#   joins(:payload_requests)
# end


end

# user_agent = UserAgent.parse(string)
# user_agent.browser
# # => 'Chrome'
# user_agent.version
# # => '19.0.1084.56'
# user_agent.platform
# # => 'Macintosh'
