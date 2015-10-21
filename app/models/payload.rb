module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :sources
  end
end
