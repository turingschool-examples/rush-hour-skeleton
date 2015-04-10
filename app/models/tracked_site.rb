module TrafficSpy
  class TrackedSite < ActiveRecord::Base
    has_many :payloads

    validates :url, presence: true

    def average_response_time
      payloads.average(:responded_in).to_f.round
    end
  end
end
