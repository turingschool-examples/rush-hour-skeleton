class RemoveResolutionColumns < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :resolution_width
    remove_column :payload_requests, :resolution_height
  end
end
