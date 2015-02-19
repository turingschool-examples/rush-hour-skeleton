class Identifier < ActiveRecord::Base
  validates :name, uniqueness: true
  validates_presence_of :name, :root_url
  has_many :payloads
end
