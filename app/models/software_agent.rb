class SoftwareAgent < ActiveRecord::Base
  validates :browser, :version, :platform, presence: true
  has_many :payload_requests
end
