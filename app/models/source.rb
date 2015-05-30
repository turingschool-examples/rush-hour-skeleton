module TrafficSpy
  class Source < ActiveRecord::Base
    has_many :payloads
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true

    def find_payloads
      Payload.find_by(source_id: self.id)
    end

    def find_urls
      Payload.all
    end

  end
end
