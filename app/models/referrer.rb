class Referrer < ActiveRecord::Base
  validates :referredBy, presence: true
end
