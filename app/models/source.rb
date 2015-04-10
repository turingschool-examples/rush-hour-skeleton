module TrafficSpy  
  class Source < ActiveRecord::Base
    validates :identifier, presence: true
    validates :root_url, presence: true

    has_many :payloads
    has_many :urls, through: :payloads

    def urls
      urls = Payload.pluck(:url_id)
      urls.flat_map {|url| Url.where(id: url).pluck(:name)}
    end

    def ordered_urls
      frequency = urls.reduce(Hash.new(0)) { |h, v| h[v] += 1; h}
      urls.uniq.sort_by {|v| frequency[v] }.reverse
    end

    def ordered_url_response_times
      response_times = payloads.sort_by { |pl| pl.url.average_response_time }.reverse
      response_times.map { |pl| "#{pl.url.name}: #{pl.url.average_response_time}"}.uniq
    end
  end
end