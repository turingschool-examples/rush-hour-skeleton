require 'uri'
class Url < ActiveRecord::Base
  has_many :payloads



  def path
    "#{URI(self[:url]).path}"
  end

  def urls
    payloads.group(:url, [:url]).count
  end

  def user_agents
    payloads.group(:operating_system).count
  end


end
