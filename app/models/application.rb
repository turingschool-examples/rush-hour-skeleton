class Application < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
  has_many :requests
  has_many :urls, through: :requests
  has_many :events, through: :requests

  def unique_urls
    urls.group(:path).count
  end

  def unique_browsers
    requests.group(:browser).count
  end

  def unique_os
    requests.group(:os).count
  end

  def unique_resolutions
    requests.group(:resolution).count
  end

  def url_by_response_time
    urls.uniq.map do |url|
      url.requests.average(:response_time).to_i
    end
  end

  def unique_events
    events.group(:name).count.sort.reverse
  end

  def ordered_events
    events.uniq.map do |event|
      [event,event.requests.count]
    end.sort_by{|event|event[1]}.reverse
  end

  # def ordered_events
  #   events.uniq.order
  # end
end
