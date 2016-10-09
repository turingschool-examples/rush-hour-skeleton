class Url < ActiveRecord::Base

  has_many :payloads

  validates :url, presence: true
end
