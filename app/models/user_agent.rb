class UserAgent < ActiveRecord::Base
  validates "os", presence: true
  validates "browser", presence: true

  belongs_to :payload_requests
end
