module TrafficSpy
  class UserAgent < ActiveRecord::Base
    has_many :payloads

    # def parse_user_agent
    #
    #   User_Agent.parse(string)
    # end

  end
end
