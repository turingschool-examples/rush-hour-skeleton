module TrafficSpy
  class Resolution < ActiveRecord::Base
    has_many :payloads

    def self.dimension(k)
      find_by(id: k).dimension
    end

  end
end
