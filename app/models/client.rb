class Client < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name, message: "%{value} already taken."
  validates :root_url, presence: true

end
