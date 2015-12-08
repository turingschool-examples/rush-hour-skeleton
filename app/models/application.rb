module TrafficSpy
  class Application < ActiveRecord::Base
    validates_presence_of :identifier_name, :root_url
    validates_uniqueness_of :identifier_name
  end
end
