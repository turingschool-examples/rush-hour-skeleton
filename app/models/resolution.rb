class Resolution < ActiveRecord::Base
  validates :width, :height, presence: true

  has_many :payload_requests
end
