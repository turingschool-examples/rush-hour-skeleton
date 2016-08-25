class ReferrerUrl < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true
  validates :name, uniqueness: true
end
