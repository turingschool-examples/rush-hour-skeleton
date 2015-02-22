class ChangePayloadTableUrlIdColumnToInteger < ActiveRecord::Migration
  def change
    remove_column :payloads, :url_id
    add_column :payloads, :url_id, :integer
  end
end
