class UserAgentStat < ActiveRecord::Base
  validates :browser, presence: true
  validates :operating_system, presence: true
  
  has_many :payloads
end
