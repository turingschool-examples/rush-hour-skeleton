class Url < ActiveRecord::Base
  validates "url", presence: true

  belongs_to :payload_requests
end
