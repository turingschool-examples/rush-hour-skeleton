module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :rootUrl
    validates :identifier, uniqueness: true
  end
end
