class Url < ActiveRecord::Base

  has_many :payload
  validates :page, presence: true
  validates_uniqueness_of :page

end
