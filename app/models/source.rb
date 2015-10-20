module TrafficSpy
  class Source < ActiveRecord::Base
    belongs_to :users
    validates_presence_of :identifier,
                          :root_url
  end
end
