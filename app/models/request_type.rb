module TrafficSpy
  class RequestType < ActiveRecord::Base
    has_many :payloads
  end
end
