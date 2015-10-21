module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :sources

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
                          :ip,
                          :unique_hash

    validates_uniqueness_of :unique_hash
  end
end
