class Source < ActiveRecord::Base
  validates :identifier, presence: true
  validates :root_url, presence: true

  has_many :payloads

  # def urls
  #   payloads.find_urls
  # end
end