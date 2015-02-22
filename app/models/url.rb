class Url < ActiveRecord::Base

  belongs_to :payload
  validates :page, presence: true
  validates_uniqueness_of :page

end