class Event < ActiveRecord::Base
  has_many :payloads
  
  validates :name, presence: true

  def self.most_frequent_event_name
    self.group(:name).order("count_name desc").count("name")
  end
end
