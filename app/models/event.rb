class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.most_to_least_requested
    joins(:payload_requests).group(:name).order("count_all desc").count
  end
end
