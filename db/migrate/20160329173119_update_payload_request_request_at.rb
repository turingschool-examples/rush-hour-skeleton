class UpdatePayloadRequestRequestAt < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove  :responded_in_id
      t.integer :response_time_id
    end
  end
end
