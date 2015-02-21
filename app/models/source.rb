class Source < ActiveRecord::Base
  validates :rootUrl, :identifier, uniqueness: true, presence: true
  has_many :payloads
end
