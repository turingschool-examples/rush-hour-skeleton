require 'uri'
class Url < ActiveRecord::Base
  has_many :payloads

  def path
    "#{URI(self[:url]).path}"
  end
end
