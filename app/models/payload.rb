module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source
    belongs_to :url

  end
end
