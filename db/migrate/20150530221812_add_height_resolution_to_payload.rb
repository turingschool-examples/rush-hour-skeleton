class AddHeightResolutionToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :resolution_height, :text
  end
end
