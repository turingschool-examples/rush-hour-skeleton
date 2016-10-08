class Visitor < ActiveRecord::Base
  validates :ip, presence: true
  validates :ip, uniqueness: true

  has_many :payloads
end
