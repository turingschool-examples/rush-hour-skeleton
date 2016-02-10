class Url < ActiveRecord::Base
  has_many :payloads
  validates :address, presence: true
end
