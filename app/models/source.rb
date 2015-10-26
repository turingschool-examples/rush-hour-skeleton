module TrafficSpy
  class Source < ActiveRecord::Base
    has_many :payloads
    validates_presence_of :identifier,
                          :root_url

    validates :identifier, uniqueness: :true

    def payload(source)
      Payload.where(source_id: source.id)
    end

    def url_counts(source)
      payload(source).group(:url).count.sort_by { |url, count| count }.reverse
    end

    def resolutions(source)
      payload(source).group(:resolution_height, :resolution_width).count
    end

    def response_times(source)
      average_response_times = payload(source).group(:url).average(:responded_in)
      response_times = {}
      average_response_times.each { |k,v| response_times[k] = v.to_i }
      response_times.sort_by { |k,v| -v }
    end

    def agents(source)
      payload(source).map { |payload| payload.user_agent }
    end

    def browsers(source)
      agents(source).map { |user_agent| UserAgent.parse(user_agent).browser }
    end

    def browser_counts(source)
      browsers(source).inject(Hash.new(0)) {|browser, count| browser[count] += 1; browser}.sort
    end

    def os_counts(source)
      os = agents(source).map { |user_agent| UserAgent.parse(user_agent).platform}
      os_counts = os.inject(Hash.new(0)) {|os, count| os[count] += 1; os}.sort
    end

    def url_index(source)
      source.payloads(source).pluck(:url).uniq
    end
  end
end
