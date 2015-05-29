class Source < ActiveRecord::Base
  validates :root_url, presence: true
  validates :identifier, uniqueness: true, presence: true

  has_many :payloads
  
end
