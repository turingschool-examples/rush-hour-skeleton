class UrlsStatisticsCalculator
  attr_reader :url, :all_urls

  def initialize(url)
    @url = url
    @all_urls = get_all_urls
  end

  def find_longest_response_time
    all_urls.max_by{|path| path[:responded_in]}[:responded_in]
  end

  def get_all_urls
    Url.all.select do |other_urls|
      url.path == other_urls.path
    end
  end

  def find_shortest_response_time
    all_urls.min_by{|path| path[:responded_in]}[:responded_in]
  end

  def find_average_response_time
    all_urls.reduce(0) do |total, url|
      total += url[:responded_in]
    end/all_urls.size
  end

  def get_http_verbs
    all_urls.map do |url|
      url[:request_type]
    end.join(", ")
  end

  def get_referred_by
    all_urls.map do |url|
      url[:referred_by]
    end.sort.reverse.uniq.join(", ")
  end

  def get_user_agents
    agents = all_urls.map do |url|
      url.user_agents.each do |agents|
        begin
          agents.each_with_object(Hash.new(0)) { |agent,counts| counts[agent[:name]] += 1 }
        rescue
          nil
        end
      end
    end
  end

end
