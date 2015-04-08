class Payload < ActiveRecord::Base
  has_one :user_agent
  has_one :referer
  has_one :resolution
  has_one :ip
  has_one :tracked_site
  has_one :event

  validates :requested_at, presence: true, uniqueness: true
  
end