module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :application
  end
end
