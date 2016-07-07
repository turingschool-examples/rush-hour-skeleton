class PayloadRequest < ActiveRecord::Base
  validates :payload_request, presence: true

  belongs_to :url
  belongs_to :requested_at
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :user_agent
  belongs_to :resolution_height
  belongs_to :resolution_weight
  belongs_to :ip
end
