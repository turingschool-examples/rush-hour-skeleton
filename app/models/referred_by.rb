class ReferredBy < ActiveRecord::Base

  validates :root_url, presence: true
  validates :path, presence: true

end
