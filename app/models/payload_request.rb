require 'json'
require 'useragent'

def parse_it(request)
  JSON.parse("#{request}")
end

def valid_columns
  {"url" => :url, "requestedAt" => :requested_at,
   "respondedIn" => :responded_in, "referredBy" => :referred_by,
   "requestType" => :request_type, "userAgent" => :user_agent,
   "resolutionWidth" => :resolution_width,
   "resolutionHeight" => :resolution_height, "ip" => :ip}
end

def assign_data(data)
  data.map do |key, value|
    [valid_columns[key], value]
  end.to_h
end

def payload_request_data(formatted_data)

end

class PayloadRequest < ActiveRecord::Base
  #presumably will put in this space belongs_to :url, etc., all the class names, once we make those.
  # belongs_to :url
  # belongs_to :request_type
  # belongs_to :resolution
  # belongs_to :ip
  # belongs_to :user_agent
  # belongs_to :referred_by

  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :user_agent, presence: true
  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
  validates :ip, presence: true

end
