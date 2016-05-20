class RespondedIn < ActiveRecord::Base
  has_many :payload_requests

  validates :time, presence: true, uniqueness: true

end
