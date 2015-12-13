class Application < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
  has_many :requests
  has_many :urls, through: :requests

  def unique_urls
    urls.group(:path).count.to_a.sort { |x,y| x[1] <=> y[1] }.reverse
  end

  def unique_browsers
    requests.group(:browser).count.to_a.sort { |x,y| x[1] <=> y[1] }.reverse
  end

  def unique_os
    requests.group(:os).count.to_a.sort { |x,y| x[1] <=> y[1] }.reverse
  end

  def unique_resolutions
    requests.group(:resolution).count.to_a.sort { |x,y| x[1] <=> y[1] }.reverse
  end

  def url_by_response_time
    urls.uniq.map do |url|
      [ url.path, url.requests.average(:response_time).to_i]
    end
  end

  def url_hyperlinks
    urls.uniq.map do |url|
      "<a href='/sources/#{identifier}/urls/#{url.path}'>/#{url.path}</a>"
    end
  end

  def events_page_link
    "<a href='/sources/#{identifier}/events'>Events Page</a>"
  end

  def comprehensive_url_data
    popularity = urls.group(:path).count

    urls.uniq.map do |url|
      { :name => "<a href='/sources/#{identifier}/urls/#{url.path}'>/#{url.path}</a>",
        :frequency => popularity[url.path],
        :response_time => url.requests.average(:response_time).to_i
      }
    end
  end


end
