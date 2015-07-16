class Registration < ActiveRecord::Base
  validates_uniqueness_of :identifier
  has_many :payloads

  def urls
    payloads.group(:url).count
  end
  #
  # def user_agents
  #   UserAgent.all.map do |
  #   end
  # end

  def screen_resolutions
  payloads.group(:screen_resolution).count
  end
end
