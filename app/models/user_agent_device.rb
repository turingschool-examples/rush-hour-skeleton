class UserAgentDevice < ActiveRecord::Base
  validates :browser, :os, presence: true
  has_many :payload_requests
end
