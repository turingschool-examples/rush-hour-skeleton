class Client < ActiveRecord::Base
  has_many :payloads
  has_many :urls, through: :payloads
  validates :root_url, presence: true
  validates :identifier, presence: true, uniqueness: true
end
