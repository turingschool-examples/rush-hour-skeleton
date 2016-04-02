class UpdatePayloadRequestToHaveClientId < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.integer :client_id
    end
  end
end
