
module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source
    validates  :sha, presence: true, uniqueness: true 


    def self.generate_sha(payload)
      Digest::SHA1.hexdigest(payload)
    end
  end
end
