class UrlDataRenderer
  attr_reader :relative_path,
              :slowest_response_time,
              :fastest_response_time,
              :average_response_time,
              :http_verbs,
              :top_referrers,
              :top_browsers,
              :top_platforms

  def initialize(relative_path, url)
    @relative_path = relative_path
    @slowest_response_time = url.payloads.maximum(:responded_in)
    @fastest_response_time = url.payloads.minimum(:responded_in)
    @average_response_time = url.payloads.average(:responded_in).round(2)
    @http_verbs = url.payloads.group(:request_type).count.sort_by { |_, v| v }.reverse
    @top_referrers = url.payloads.group(:referrer).count.sort_by { |_, v| v }.reverse
    @top_browsers = url.payloads.group(:browser).count.sort_by { |_, v| v }.reverse
    @top_platforms = url.payloads.group(:platform).count.sort_by { |_, v| v }.reverse
  end
end