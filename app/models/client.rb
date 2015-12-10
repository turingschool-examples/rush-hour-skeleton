class Client < ActiveRecord::Base

  has_many :payloads
  # has_many :events, through: :payloads

  validates :name, presence: true
  validates :root_url, presence: true

end
