class Url < ActiveRecord::Base
  validates :url_address, presence: true
  validates :url_address, uniqueness: true

  has_many :payloads
end
