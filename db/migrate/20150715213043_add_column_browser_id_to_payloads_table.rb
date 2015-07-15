class AddColumnBrowserIdToPayloadsTable < ActiveRecord::Migration
  def change
    add_column :payloads, :browser_id, :integer 
  end
end
