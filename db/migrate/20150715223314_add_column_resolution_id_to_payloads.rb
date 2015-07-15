class AddColumnResolutionIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :resolution_id, :integer 
  end
end
