class AddResponseIdColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :response_id, :integer
  end
end
