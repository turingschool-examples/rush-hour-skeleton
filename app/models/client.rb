class Client < ActiveRecord::Base
  validates :identifier, :root_url presence: true
  has_many :payload_requests
end
