class Client < ActiveRecord::Base
  validates :root_url, presence: true
  validates :identifier, presence: true, uniqueness: true
  has_many :payload_requests

end
