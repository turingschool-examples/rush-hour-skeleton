module TrafficSpy
  class Payload < ActiveRecord::Base
    # validates_presence_of :payload
    validates_presence_of :url,
                          :requestedAt,
                          :respondedIn,
                          :referredBy,
                          :requestType,
                          :eventName,
                          :userAgent,
                          :resolutionWidth,
                          :resolutionHeight,
                          :ip

  end
end
