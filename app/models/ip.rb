class Ip < ActiveRecord::Base
  has_many :payloads
  validates :address, presence: true, uniqueness: true
end
