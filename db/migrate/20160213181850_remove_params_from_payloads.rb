class RemoveParamsFromPayloads < ActiveRecord::Migration
  def change
    remove_column :payloads, :parameters
  end
end
