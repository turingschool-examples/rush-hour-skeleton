class Payload < ActiveRecord::Base
  belongs_to :source
  has_many :urls

  validates :digest, presence: true, uniqueness: true
end
