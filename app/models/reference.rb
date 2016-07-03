class Reference < ActiveRecord::Base
  validates "reference", presence: true

  has_many :payload_requests
  has_many :urls, through: :payload_requests

end
