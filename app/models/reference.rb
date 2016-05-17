class Reference < ActiveRecord::Base
  validates "reference", presence: true

  belongs_to :payload_requests
end
