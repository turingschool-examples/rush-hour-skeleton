class UAgent < ActiveRecord::Base
  has_many :payload_requests
  validates :browser, presence: true
  validates :browser, uniqueness: true
  validates :operating_system, presence: true
  validates :operating_system, uniqueness: true
end
