class Source < ActiveRecord::Base
  validates :root_url, presence: true
  validates :identifier, uniqueness: true, presence: true

  has_many :payloads

  def group_urls
    payloads.group(:url).count.sort_by { |k, v| v }.reverse
  end
end
