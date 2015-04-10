module TrafficSpy
  class Url < ActiveRecord::Base
    has_many :payloads

    def average_response_time
      payloads.average(:responded_in).to_f.round
    end
  end
end