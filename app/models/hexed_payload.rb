class HexedPayload < ActiveRecord::Base

  belongs_to :client

  validates :hexed_payload, presence: true

end
