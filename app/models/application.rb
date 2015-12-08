module TrafficSpy
  class Application < ActiveRecord::Base
    validates_presence_of :identifier_name, :root_url
  end
end
