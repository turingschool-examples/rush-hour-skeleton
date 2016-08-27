require 'useragent'

class UAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :agent, presence: true, uniqueness: true

# def self.all_u_agents
#   joins(:payload_requests)
# end


end
