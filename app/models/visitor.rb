class Visitor < ActiveRecord::Base
  validates :ip, presence: true

  has_many :payloads
end
