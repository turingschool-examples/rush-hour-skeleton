module TrafficSpy
  class ScreenResolution < ActiveRecord::Base
    has_many :payloads
  end
end
