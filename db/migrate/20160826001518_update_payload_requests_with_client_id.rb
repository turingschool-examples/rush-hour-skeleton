class UpdatePayloadRequestsWithClientId < ActiveRecord::Migration
  def change
    add_reference :payload_requests, :client, index: true
  end
end
