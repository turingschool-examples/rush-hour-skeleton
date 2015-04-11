class ScreenResolution < ActiveRecord::Base
  belongs_to :user_agent
  has_many :payloads
end
