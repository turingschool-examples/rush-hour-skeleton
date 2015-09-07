class Source < ActiveRecord::Base
  has_many :payloads
  has_many :urls, through: :payloads
  has_many :responses, through: :payloads
  has_many :browsers, through: :payloads
  has_many :resolutions, through: :payloads

  validates :root_url, presence: true, uniqueness: true
  validates :identifier, presence: true, uniqueness: true
end
