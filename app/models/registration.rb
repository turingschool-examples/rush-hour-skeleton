class Registration < ActiveRecord::Base
  validates_uniqueness_of :identifier
  has_many :payloads
  has_many :urls, through: :payloads
end
