class AddReferencesForPayloadRequest < ActiveRecord::Migration
  def change
    add_reference :payload_requests, :url, index: true
    add_reference :payload_requests, :referrer, index: true
    add_reference :payload_requests, :request, index: true
    add_reference :payload_requests, :user_agent_b, index: true
    add_reference :payload_requests, :resolution, index: true
    add_reference :payload_requests, :ip, index: true
    add_reference :payload_requests, :client, index: true
  end
end
