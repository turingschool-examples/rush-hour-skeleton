class UpdatePayloadRequestsWithIndex < ActiveRecord::Migration
  def change
    add_index(:payload_requests, :url_id)
    add_index(:payload_requests, :source_id)
    add_index(:payload_requests, :request_type_id)
    add_index(:payload_requests, :user_agent_id)
    add_index(:payload_requests, :screen_resolution_id)
  end
end
