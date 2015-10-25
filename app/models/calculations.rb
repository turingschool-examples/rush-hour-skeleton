module TrafficSpy
  class Calculations
    def self.application_details(payload)
      url_counts = payload.group(:url).count.sort_by { |url, count| count }.reverse
      agents = payload.map do |payload|
        payload.user_agent
      end
      browsers = agents.inject(Hash.new(0)) {|browser, count| browser[count] += 1; browser}.sort
      browser_counts = browsers.map do |user_agent, count|
        [UserAgent.parse(user_agent).browser, count]
      end
      os = agents.inject(Hash.new(0)) {|os, count| os[count] += 1; os}.sort
      os_counts = browsers.map do |user_agent, count|
        [UserAgent.parse(user_agent).platform, count]
      end
      resolutions = payload.group(:resolution_height, :resolution_width).count
      average_response_times = payload.group(:url).average(:responded_in)
      @response_times = {}
      average_response_times.each { |k,v| @response_times[k] = v.to_i }
      response_times = @response_times.sort_by { |k,v| -v }
      {url_counts: url_counts,
       browser_counts: browser_counts,
       os_counts: os_counts,
       resolutions: resolutions,
       response_times: response_times
      }
    end
  end
end
