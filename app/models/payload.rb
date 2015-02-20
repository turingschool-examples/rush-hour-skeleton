class Payload < ActiveRecord::Base
  validates_presence_of :url_id, :requested_at, :responded_in, :referred_by_id, :request_type_id, :parameters,
    :event_name_id, :user_agent_id, :resolution_id,
    :ip_id, :source_id

  belongs_to :source

  def simplified_json
    { "payload" => payload }.to_json
  end

  def error_response
    errors.full_messages.join ", "
  end
end
