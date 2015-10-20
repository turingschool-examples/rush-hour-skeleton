module TrafficSpy
  class Source < ActiveRecord::Base
    belongs_to :sources
    validates_presence_of :identifier,
                          :root_url

    validates :identifier, uniqueness: :true
  end
end
