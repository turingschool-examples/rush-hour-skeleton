class Payload < ActiveRecord::Base
  belongs_to :source
  belongs_to :url
  belongs_to :browser
  belongs_to :resolution

  validates :digest, presence: true, uniqueness: true
end
