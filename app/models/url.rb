class Url < ActiveRecord::Base
  has_many :payload_requests

  validates  :web_address, presence: true
  validates :web_address, uniqueness: true
end
