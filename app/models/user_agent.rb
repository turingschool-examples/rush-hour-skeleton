class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
end
