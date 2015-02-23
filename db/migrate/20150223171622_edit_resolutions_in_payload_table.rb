class EditResolutionsInPayloadTable < ActiveRecord::Migration
  def change
    remove_column :payloads, :resolution_id
    add_column :payloads, :resolutionWidth, :integer
    add_column :payloads, :resolutionHeight, :integer
  end
end
