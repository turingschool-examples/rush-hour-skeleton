class SoftwareAgent < ActiveRecord::Base
  validates "os", presence: true
  validates "browser", presence: true

  has_many :payload_requests
end
