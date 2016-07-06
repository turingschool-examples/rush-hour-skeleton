class RemoveIpColumnFromPayloadRequestsTable < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :ip, :text
  end
end
