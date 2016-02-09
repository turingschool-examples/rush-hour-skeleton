class Payload < ActiveRecord::Base
  validates :requestedAt, presence :true
  validates :respondedIn, presence :true
  # model as response
  validates :referredBy, presence :true
  validates :parameters, presence :true
  # has many parameters
  belongs_to :event_names
  belongs_to :ips
  belongs_to :referred_bys
  belongs_to :resolutions
  belongs_to :urls
  belongs_to :user_environments
end
