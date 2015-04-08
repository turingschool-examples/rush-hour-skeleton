class Payload < ActiveRecord::Base
  # has_one :client_id
  belongs_to :client
  belongs_to :referer
  belongs_to :resolution
  belongs_to :address
  belongs_to :tracked_site
  belongs_to :event
  belongs_to :request
  belongs_to :agent

  # validates :requested_at, presence: true, uniqueness: true
  
end