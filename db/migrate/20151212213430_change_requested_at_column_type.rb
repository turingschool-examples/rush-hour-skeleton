class ChangeRequestedAtColumnType < ActiveRecord::Migration
  def up
    change_column :payloads, :requested_at, :time
  end

  def down
    change_column :payloads, :requested_at, :datetime
  end
end
