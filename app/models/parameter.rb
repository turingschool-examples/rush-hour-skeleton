class Parameter < ActiveRecord::Base
  has_many :payload_requests

  validates :list, presence: true, uniqueness: true

end
