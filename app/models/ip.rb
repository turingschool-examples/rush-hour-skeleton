class Ip < ActiveRecord::Base
  has_many :payload

  validates :address, presence: true

end
