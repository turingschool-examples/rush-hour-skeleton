class Url < ActiveRecord::Base
  has_many :payloads
  validates :route, presence: true
end
