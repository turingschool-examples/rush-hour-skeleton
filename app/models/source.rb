module TrafficSpy  
  class Source < ActiveRecord::Base
    validates :identifier, presence: true
    validates :root_url, presence: true

    has_many :payloads

    def urls
      urls = Payload.pluck(:url_id)
      urls.flat_map {|url| Url.where(id: url).pluck(:name)}
    end

    def ordered_urls
      frequency = urls.reduce(Hash.new(0)) { |h, v| h[v] += 1; h}
      urls.uniq.sort_by {|v| frequency[v] }.reverse
    end
  end
end