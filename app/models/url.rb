class Url < ActiveRecord::Base
  has_many :payloads
  has_one :source, through: :payloads

  validates :url, presence: true, uniqueness: true
end
