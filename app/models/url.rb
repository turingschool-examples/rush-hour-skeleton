require 'uri'

class Url < ActiveRecord::Base
  has_many :payloads
  has_one :source, through: :payloads
  has_many :responses, through: :payloads

  validates :url, presence: true, uniqueness: true

  def most_requested(source)
    slugs = source.urls.group(:url).count
    slugs.map do |slug|
      slug[0]
    end
  end

  def path_parser(source)
    paths = source.urls.map do |url|
      URI(url.url).path
    end
  end
end
