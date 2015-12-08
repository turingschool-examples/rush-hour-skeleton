class Client < ActiveRecord::Base

  validates :name, presence: true
  # validates :name, uniqueness: true, message: "Name already taken."
  validates :root_url, presence: true

end
