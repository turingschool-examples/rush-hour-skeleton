module TrafficSpy
  class UserAgent < ActiveRecord::Base
    has_many :payloads
    has_many :screen_resolutions
  end
end
