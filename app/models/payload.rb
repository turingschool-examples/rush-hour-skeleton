class Payload < ActiveRecord::Base
  belongs_to :url
  belongs_to :referral
  belongs_to :request
  belongs_to :event
  belongs_to :user_agent
  belongs_to :ip
  belongs_to :dimension
  belongs_to :identifier
end
