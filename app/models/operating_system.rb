module TrafficSpy
  class OperatingSystem < ActiveRecord::Base
    has_many :payloads
  end
end
