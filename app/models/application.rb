module TrafficSpy
  class Application < ActiveRecord::Base
    validates_presence_of :identifier, :root_url
    validates_uniqueness_of :identifier
  end
end
