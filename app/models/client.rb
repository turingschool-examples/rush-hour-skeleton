class Client < ActiveRecord::Base
  has_many :payloads

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
end
