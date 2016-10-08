class RequestType < ActiveRecord::Base
  has_many :payload

  validates :http_verb, presence: true

end
