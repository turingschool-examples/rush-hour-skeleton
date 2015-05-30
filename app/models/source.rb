module TrafficSpy
  class Source < ActiveRecord::Base
    has_many :payloads
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true

    # def find_payloads
    #   Payload.find_by(source_id: self.id)
    # end

    def list_urls

      payloads.group(:url).order('count_url DESC').count(:url)

      # keys = payloads.group(:url).order('count_url DESC').count(:url).keys
      # keys.each do |key|
      #   payloads.group(:url).order('count_url DESC').count(:url)
      # end
    end

  end
end
