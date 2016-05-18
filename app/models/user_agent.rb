class UserAgentB < ActiveRecord::Base
  belongs_to :payload_request

  validates :browser, presence: true
  validates :version, presence: true
  validates :platform, presence: true
end
