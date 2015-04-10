module TrafficSpy
  class Resolution < ActiveRecord::Base
    has_many :payloads
    validates :height_width, presence: true, uniqueness: true
  end
end
