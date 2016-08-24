class IP < ActiveRecord::Base
  belongs_to :payload_request

  validates :address, presence: true
end
