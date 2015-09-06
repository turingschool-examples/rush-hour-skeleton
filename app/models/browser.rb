class Browser < ActiveRecord::Base
  has_many :payloads
  has_one :source, through: :payloads

  validates :browser, presence: true, uniqueness: true
end