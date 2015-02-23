class Payload < ActiveRecord::Base
  belongs_to :user
  has_many :ips
  has_many :urls
  has_many :events
  has_many :refferedBies
  has_many :userAgents
  has_many :resolutions
  has_many :requestTypes
  has_many :requestedAts
  has_many :respondedIns
end
