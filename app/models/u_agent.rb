class UAgent < ActiveRecord::Base  
  has_many :payload_requests

  validates :browser, presence: true
  validates :operating_system, presence: true
end
