module TrafficSpy
  class Resolution < ActiveRecord::Base
    has_many :payloads
    validates :height_width, presence: true, uniqueness: true

    def payloads_resolutions
      payloads.select(:height_width)
    end

  end
end
