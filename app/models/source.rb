class Source < ActiveRecord::Base
  has_many :payloads

  validates :root_url, presence: true
  validates :identifier, uniqueness: true, presence: true
end
