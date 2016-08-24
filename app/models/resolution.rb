class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :height, :width, presence: true
  validates :height, uniqueness: {scope: :width}
  validates :width, uniqueness: {scope: :height}
end
