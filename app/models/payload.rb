module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :source

    validates_presence_of :url,
                          :requestedAt,
                          :respondedIn,
                          :referredBy,
                          :requestType,
                          :parameters,
                          :eventName,
                          :userAgent,
                          :resolutionHeight,
                          :resolutionWidth,
                          :ip

    validates_uniqueness_of :unique_hash
  end
end
