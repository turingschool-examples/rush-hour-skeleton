class Referrer < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests

  validates :name, presence: true
end
