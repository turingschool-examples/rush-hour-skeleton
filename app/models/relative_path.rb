module TrafficSpy
  class RelativePath < ActiveRecord::Base
    has_many :payloads
  end
end
