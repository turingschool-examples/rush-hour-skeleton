class VariableBuilder
  attr_reader :params, :source, :visits, :user_agents

  def initialize(params, source)
    @params = params
    @source = source
    @visits = Visit.where(source_id: source.id)
    @user_agents = visits.map {|visit| UserAgent.parse(visit.user_agent)}
  end

  def variables
    {identifier: identifier,
     urls: urls,
     screen_resolutions: screen_resolutions,
     browsers: user_browsers,
     os_platforms: os_platforms}
  end

  private

  def identifier
    source.identifier.capitalize
  end

  def urls
    raw_urls = visits.map {|visit| visit.url}
    urls = raw_urls.map.with_object(Hash.new(0)) do |url, hash|
      hash[url] += 1
    end
    urls.to_a.max_by(raw_urls.count) {|url, visit_count| visit_count}
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

end
