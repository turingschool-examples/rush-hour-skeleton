module TrafficSpy
  class Ip < ActiveRecord::Base
    has_many :payloads
  end
end
