module TrafficSpy
  class Payload < ActiveRecord::Base
    Digest::SHA1.hexdigest
    belongs_to :source
  end
end
