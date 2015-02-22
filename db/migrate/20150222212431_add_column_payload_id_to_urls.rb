class AddColumnPayloadIdToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :payload_id, :integer
  end
end
