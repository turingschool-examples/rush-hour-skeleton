class ChangePayloadRequestResponseIdToResponseTime < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove  :response_time_id
      t.integer :response_time
    end
  end
end
