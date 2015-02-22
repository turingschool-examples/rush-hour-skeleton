require 'uri'

class Url < ActiveRecord::Base
  validates :address, presence: true

  has_many :payloads

  def relative_path(uri)
    URI(uri).path.split('/').last
  end
end
