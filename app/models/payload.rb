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
end
