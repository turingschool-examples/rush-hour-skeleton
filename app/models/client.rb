class Client < ActiveRecord::Base

  has_many :payloads
  has_many :request_types, through: :payloads
  has_many :urls, through: :payloads
  has_many :agents, through: :payloads
  has_many :resolutions, through: :payloads
  has_many :event_names, through: :payloads

  validates :identifier, presence: true
  validates :root_url, presence: true

  def all_event_names
    event_names.pluck(:event_name).uniq
  end

end
