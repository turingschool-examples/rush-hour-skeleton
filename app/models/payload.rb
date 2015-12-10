module TrafficSpy
  class Payload < ActiveRecord::Base
    # validates :identifier, presence: true, uniqueness: true
    belongs_to :user
    belongs_to :resolution


    def self.url_popularity
      group(:url).count.sort.to_h
    end

    def self.browser_popularity
      group(:user_agent).count.sort.to_h
    end

    def self.os_popularity
      group(:os).count.sort.to_h
    end

    def self.resolution_popularity
      group(:resolution_id).count.sort.to_h
    end

    def self.avg_response_time
      group(:url).average(:responded_in)
    end

  end
end
