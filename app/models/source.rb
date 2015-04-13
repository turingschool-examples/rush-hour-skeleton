require 'byebug'
class Source < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true

  has_many :payloads
  has_many :urls, through: :payloads


  def ordered_url
    urls = Url.pluck(:url)
    most_requested = urls.group_by {|url| url}.inject({}) do |counts, (key,value)|
      counts[key] = value.size
      counts
    end.sort_by{|value| value[1]}.reverse
  end

  def url_objects
    payloads = Payload.all
    payloads.map{|payload| payload.url}.uniq
  end

end
