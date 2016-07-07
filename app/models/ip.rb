class Ip < ActiveRecord::Base
  # validates :ip, presence: true

  has_many :payload_requests
end
