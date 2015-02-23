class Reference < ActiveRecord::Base
  validates :link, presence: true

  has_many :payloads
end
