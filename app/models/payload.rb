
module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source
    validates  :sha, presence: true, uniqueness: true 


    def self.generate_sha(payload)
      Digest::SHA1.hexdigest(payload)
    end

    def self.confirm_payload(params)
      ["url",
       "requestedAt",
       "respondedIn",
       "referredBy",
       "requestType",
       "eventName",
       "userAgent",
       "resolutionWidth",
       "resolutionHeight",
       "ip",
       "splat",
       "captures",
       "identifier"].sort != params.keys.sort
    end
  end
end
