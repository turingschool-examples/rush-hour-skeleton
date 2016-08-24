class Resolution < ActiveRecord::Base
  belongs_to :payload_request

  validates :height, presence: true
  validates :width, presence: true
end
