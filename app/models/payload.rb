class Payload < ActiveRecord::Base
  validates  :requested_at, presence: true
  validates  :response_time, presence: true
  validates  :parameters, presence: true
  # has many parameters
  belongs_to :event
  belongs_to :ip
  belongs_to :refer
  belongs_to :resolution
  belongs_to :url
  belongs_to :user_environment
  belongs_to :request_type

  def self.average_response_time
    self.average(:response_time).to_i
  end

  def self.min_response_time
    self.minimum(:response_time).to_i
  end

  def self.max_response_time
    self.maximum(:response_time).to_i
  end

  def self.most_frequent_request_type
    self.maximum(:request_type_id)
  end

  
end
