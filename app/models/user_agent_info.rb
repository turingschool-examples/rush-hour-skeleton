class UserAgentInfo < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :version, presence: true
  validates :platform, presence: true
end
