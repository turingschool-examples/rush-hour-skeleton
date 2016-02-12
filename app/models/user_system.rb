class UserSystem < ActiveRecord::Base
  validates :browser_type, presence: true
  validates :operating_system, presence: true

  has_many :payload_requests
end
