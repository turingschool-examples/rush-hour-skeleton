module TrafficSpy
  class Agent < ActiveRecord::Base
    belongs_to :payload
  end
end
