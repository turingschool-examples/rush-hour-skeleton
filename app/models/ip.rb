class Ip < ActiveRecord::Base
  has_many :payloads
  validates :ip, presence: true
end
