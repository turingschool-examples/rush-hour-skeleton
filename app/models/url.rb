class Url < ActiveRecord::Base

  belongs_to :payload
  validates :page, presence: true

end