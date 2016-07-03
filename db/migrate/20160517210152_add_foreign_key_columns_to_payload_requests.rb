class AddForeignKeyColumnsToPayloadRequests < ActiveRecord::Migration
  def change
    add_reference(:payload_requests, :url, index: true)
    add_reference(:payload_requests, :ip_address, index: true)
    add_reference(:payload_requests, :event_name, index: true)
    add_reference(:payload_requests, :request_type, index: true)
    add_reference(:payload_requests, :resolution, index: true)
    add_reference(:payload_requests, :referred_by, index: true)
    add_reference(:payload_requests, :user_agent, index: true)
  end
end
