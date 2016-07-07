class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payload_requests
end
