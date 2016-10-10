class ReferredBy < ActiveRecord::Base
  has_many :payload

  validates :root_url, presence: true
  # validates :path, presence: true

end
