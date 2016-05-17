class ChangePayloadRequestsTable < ActiveRecord::Migration
  def change
    remove_column(:payload_requests, :url, :text)   
  end
end
