module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :root_url

    has_many :payloads
    has_many :urls, through: :payloads

    def most_requested_urls
      payloads
      binding.pry
    end

  end
end
