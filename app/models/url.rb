class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :url, presence: true
  validates :url, uniqueness: true
end
