class Source < ActiveRecord::Base
  validates :root_url, presence: true
  validates :identifier, uniqueness: true, presence: true

  has_many :payloads


  def grouped_urls
    payloads.group(:url)
  end

  def requested_urls
    grouped_urls.count.sort_by { |k, v| v }.reverse
  end

  def average_times
    grouped_urls.average(:responded_in).sort_by { |k, v| v }.reverse
  end
end
