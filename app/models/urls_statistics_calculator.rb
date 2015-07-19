class UrlsStatisticsCalculator
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def find_longest_response_time
    if !url.urls.nil?
      url.urls.order(responded_in: :desc).last[:responded_in]
    else
      nil
    end
  end


  def find_shortest_response_time
    if !url.urls.empty?
      url.urls.order(responded_in: :desc).last[:responded_in]
    else
      nil
    end
  end

  def find_average_response_time
    if !url.urls.empty?
      url.urls.average(:responded_in)
    else
      nil
    end
  end

  def get_http_verbs
    "here"
  end

  def get_referred_by
    url.payloads.first.registration[:url]
  end

end
