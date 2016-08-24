class IP < ActiveRecord::Base
  validates :address, presence: true
end
