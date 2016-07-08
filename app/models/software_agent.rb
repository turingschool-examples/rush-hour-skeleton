class SoftwareAgent < ActiveRecord::Base
  validates :message, presence: true
  has_many :payload_requests



  def self.all_browsers_used
  require "pry"; binding.pry
  end

end
