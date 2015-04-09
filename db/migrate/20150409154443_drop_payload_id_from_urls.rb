class DropPayloadIdFromUrls < ActiveRecord::Migration
  def change
    remove_column :urls, :payload_id, :integer
  end
end
