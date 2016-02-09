class UserEnvironment < ActiveRecord::Base
  has_many :payloads
  validates :userAgent, presence: true
end
