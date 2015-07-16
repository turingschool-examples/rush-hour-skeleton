class Platform < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :payloads
end
