module TrafficSpy
  class Source < ActiveRecord::Base
    belongs_to :sources
    validates_presence_of :identifier,
                          :root_url
  end
end
