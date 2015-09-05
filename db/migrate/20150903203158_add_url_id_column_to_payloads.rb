class AddUrlIdColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :url_id, :integer
  end
end
