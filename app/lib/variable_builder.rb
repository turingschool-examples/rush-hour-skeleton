class VariableBuilder
  attr_reader :params, :source, :visits, :user_agents, :urls

  def initialize(params, source)
    @params = params
    @source = source
    @visits = Visit.where(source_id: source.id)
    @user_agents = visits.map {|visit| UserAgent.parse(visit.user_agent)}
    @urls = Url.where(source_id: source.id)
  end

  def variables
    {identifier: identifier,
     addresses: addresses,
     screen_resolutions: screen_resolutions,
     browsers: user_browsers,
     os_platforms: os_platforms,
     url_response_times: url_response_times}
  end

  private

  def identifier
    source.identifier.capitalize
  end

  def addresses
    raw_addresses = urls.map {|url| [url.address, url.visits_count]}
    raw_addresses.max_by(raw_addresses.count) {|address, visits| visits}
  end

  def screen_resolutions
    resolutions = visits.map do |visit|
      "#{visit.resolution_width}x#{visit.resolution_height}"
    end
    resolutions.uniq
  end

  def user_browsers
    browsers = user_agents.map.with_object(Hash.new(0)) do |user_agent, hash|
     hash[user_agent.browser] += 1
   end
   browsers.to_a.max_by(user_agents.count) {|browser, visits| visits}
  end

  def os_platforms
    platforms = user_agents.map.with_object(Hash.new(0)) do |user_agent, hash|
     hash[user_agent.platform] += 1
   end
   platforms.to_a.max_by(user_agents.count) {|platform, visits| visits}
  end

  def url_response_times
    raw_times = urls.map do |url|
      path = url.address.gsub(source.root_url, identifier.downcase + "/urls")
      [url.address, url.average_response_time, path]
    end
    raw_times.max_by(raw_times.count) {|address, time| time}
  end

end
