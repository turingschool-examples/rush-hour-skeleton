class Browser < ActiveRecord::Base
  validates :name, presence: true

  has_many :payloads
end
