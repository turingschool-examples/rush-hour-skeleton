class Url < ActiveRecord::Base
  validates :path, presence: true, uniqueness: true
  has_many :payloads
  belongs_to :site
end
