module TrafficSpy
  class Payload < ActiveRecord::Base   
    # @digest Digest::SHA1.hexdigest
    belongs_to :source

  end
end
