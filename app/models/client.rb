class Client < ActiveRecord::Base
  has_many :urls, through: :payloads
  validates :address, presence: true
end
