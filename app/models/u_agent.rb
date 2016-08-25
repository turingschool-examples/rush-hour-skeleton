class UAgent < ActiveRecord::Base
  has_many :payload_requests
  validates :agent, presence: true

end
