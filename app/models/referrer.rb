class Referrer < ActiveRecord::Base
  validates :path, presence: true

  has_many :payloads
end
