module TrafficSpy
  class Application < ActiveRecord::Base
    validates_presence_of :identifier_name
  end
end
