class SoftwareAgent < ActiveRecord::Base
  validates :brower, :version, :platform, presence: true
  has_many :payload_requests
end
