class AddSourcesIdColumnToPayloadsTable < ActiveRecord::Migration
  def change
    add_column :payloads, :source_id, :integer
  end
end
