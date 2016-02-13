class Referrer < ActiveRecord::Base
  has_many :payload_requests

  validates :referred_by, presence: true, uniqueness: true
end
