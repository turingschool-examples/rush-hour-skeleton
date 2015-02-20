class Identifier < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  validates :root_url, presence: true
  has_many :payloads
end
