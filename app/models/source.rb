module TrafficSpy
  class Source < ActiveRecord::Base
    has_many :payloads
    validates_presence_of :identifier,
                          :root_url

    validates :identifier, uniqueness: :true
  end
end
