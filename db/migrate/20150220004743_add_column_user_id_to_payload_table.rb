class AddColumnUserIdToPayloadTable < ActiveRecord::Migration
  def change
    add_column :payloads, :user_id, :integer
    add_column :users, :payload_id, :integer
  end
end
