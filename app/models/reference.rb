class Reference < ActiveRecord::Base
  validates "reference", presence: true

  has_many :payload_requests
end
