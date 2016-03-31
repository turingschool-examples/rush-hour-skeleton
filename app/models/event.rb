class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.most_to_least_requested
    # joins(:payload_requests).group(:name).order("count_all desc").count
    self.all.sort_by { |event| event.payload_requests.count}.reverse.map { |event| event.name }
  end
end
