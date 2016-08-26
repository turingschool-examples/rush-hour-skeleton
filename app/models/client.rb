class Client < ActiveRecord::Base
  has_many :payload_requests
  validates :identifier, presence: true
  validates :root_url, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, uniqueness: true
end
