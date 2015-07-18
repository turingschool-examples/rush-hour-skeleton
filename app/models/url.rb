class Url < ActiveRecord::Base
  has_many :payloads

  def relative
    self[:url].split("/")[3]
  end

  def path
    require 'pry'
    binding.pry
    self[:url].split("/")[4]
  end
end
