class Url < ActiveRecord::Base

  belongs_to :client
  has_many :events
  has_many :user_agents

  validates :path, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :parameters, presence: true
  validates :client_id, presence: true

  def self.url_requests
    group(:path).order('count_id desc').count('id')
  end

end
