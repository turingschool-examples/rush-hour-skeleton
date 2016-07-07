class Resolution< ActiveRecord::Base
  validates :resolution, presence: true

  has_many :payload_requests
end
