class Refer < ActiveRecord::Base
  has_many :payloads
  validates :address, presence: true
end
