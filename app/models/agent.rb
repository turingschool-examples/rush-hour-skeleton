module TrafficSpy
  class Agent < ActiveRecord::Base
    has_many :payloads
    validates :user_agent, presence: true, uniqueness: true
  end
end
