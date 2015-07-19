require 'uri'
class Url < ActiveRecord::Base
  has_many :payloads
  has_many :events, through: :payloads
  has_many :urls, through: :payloads

  def path
    "#{URI(self[:url]).path}"
  end


end
