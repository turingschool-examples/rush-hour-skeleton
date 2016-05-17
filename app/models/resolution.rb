class Resolution < ActiveRecord::Base
  belongs_to :payload_request

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true

end
