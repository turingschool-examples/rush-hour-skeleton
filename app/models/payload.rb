module TrafficSpy
  class Payload < ActiveRecord::Base
    # validates :identifier, presence: true, uniqueness: true
    belongs_to :user
    belongs_to :resolution


    def self.url_popularity
      group(:url).count
    end

  end
end
