class AddScreenResolutionColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :screen_resolution_id, :integer
  end
end
