class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :height, presence: true
  validates :width,  presence: true
  validates :height, uniqueness: { scope: :width }
end
