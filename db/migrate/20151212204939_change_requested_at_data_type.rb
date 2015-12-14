class ChangeRequestedAtDataType < ActiveRecord::Migration
  def change
    remove_column :payloads, :requested_at
    add_column :payloads, :requested_at, :datetime
  end
end
