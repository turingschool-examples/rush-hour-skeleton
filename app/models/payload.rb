class Payload < ActiveRecord::Base
  validates :url_id, :requested_at, :responded_in, :reference_id,
            :request_type_id, :event_id, :user_agent_id, :resolution_id, :ip_id,
            :source_id, presence: true

  belongs_to :source
  belongs_to :url
  belongs_to :reference
  belongs_to :request_type
  belongs_to :event
  belongs_to :payload_user_agent
  belongs_to :resolution
  belongs_to :ip

  def simplified_json
    { "payload" => payload }.to_json
  end

  def error_response
    errors.full_messages.join ", "
  end
end
