class Source < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :rooturl, presence: true

  has_many :payloads
end

