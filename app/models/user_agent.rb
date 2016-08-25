class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}
  validates :browser, uniqueness: {scope: :operating_system}

  def self.get_all_browsers_count
    UserAgent.group(:browser).count(:user_agent_id)
  end
end
