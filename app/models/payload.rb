class Payload < ActiveRecord::Base
  belongs_to :source
  belongs_to :url

  validates :digest, presence: true, uniqueness: true
end
