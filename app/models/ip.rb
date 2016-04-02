class Ip < ActiveRecord::Base
  validates :address, presence: true
end
