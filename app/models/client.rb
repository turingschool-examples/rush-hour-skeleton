class Client < ActiveRecord::Base
  validates :identifier, presence: true
  validates :root_url,   presence: true

  validates :identifier, uniqueness: { scope: :root_url }
end
