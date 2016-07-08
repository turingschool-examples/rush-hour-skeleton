class Url < ActiveRecord::Base
  validates :root, :path, presence: true
  has_many :payload_requests
  # need to find a way to track the data and increment it
end
