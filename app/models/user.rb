module TrafficSpy
  class User < ActiveRecord::Base
    validates :identifier, presence: true, uniqueness: true
    has_many :payloads
  end
end
