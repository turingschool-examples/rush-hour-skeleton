class Application < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
  has_many :requests
  has_many :urls, through: :requests

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
end
