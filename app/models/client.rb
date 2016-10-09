class Client < ActiveRecord::Base
  
  has_many :payloads
  
  validates :identifier, presence: true
  validates :root_url, presence: true
  
  def self.missing_parameters(params)
    return false if Client.new(params).valid? 
    return true
  end
  
  def self.identifier_exists(params)
    return true if Client.pluck(:identifier).include?(params[:identifier])
    return false
  end
  
end