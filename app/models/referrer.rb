class Referrer < ActiveRecord::Base
  validates :path, presence: true, uniqueness: true

  has_many :payloads
end
