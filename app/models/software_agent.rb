class SoftwareAgent < ActiveRecord::Base
  validates :message, presence: true
  has_many :payload_requests
end
