class DashboardRenderer
  attr_reader :identifier,
              :site,
              :urls,
              :browsers,
              :platforms,
              :screens,
              :response_times

  def initialize(identifier, site)
    @identifier = identifier
    @site = site
    @urls = @site.payloads.group(:url).count.sort_by { |_, v| v }.reverse
    @browsers = @site.payloads.group(:browser).count.sort_by { |_, v| v }.reverse
    @platforms = @site.payloads.group(:platform).count.sort_by { |_, v| v }.reverse
    @screens = @site.payloads.group(:resolution_width, :resolution_height).count.sort_by { |_, v| v }.reverse
    @response_times = @site.payloads.group(:url).average(:responded_in).sort_by { |_, v| v }
  end
end