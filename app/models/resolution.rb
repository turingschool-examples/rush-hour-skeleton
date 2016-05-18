class Resolution < ActiveRecord::Base
  belongs_to :payload_request

  validates :width, presence: true
  validates :height, presence: true
end
