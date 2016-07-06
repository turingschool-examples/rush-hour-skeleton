class Url < ActiveRecord::Base
  validates :root, :path, presence: true
  has_many :payload_requests
end
