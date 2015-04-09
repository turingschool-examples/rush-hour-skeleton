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

  validates :composite_key, presence: true, uniqueness: true
  validates :tracked_site_id, presence: true
end