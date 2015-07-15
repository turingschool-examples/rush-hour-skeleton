module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :root_url

    has_many :payloads
    has_many :urls, through: :payloads

    def most_requested_urls
      payloads
    #   urls = payloads.order('url_id').map do |x|
    #     x.url.address
    #   end
    #   urls_frequencies = urls.group_by
    end

    # def sorted_urls
    #   frequency = urls.reduce(Hash.new(0)) { |h, v| h[v] += 1; h}
    #   urls.uniq.sort_by {|v| frequency[v] }.reverse
    # end

  end
end
