class RenameColumnsToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requestedAt, :requested_at
    rename_column :payload_requests, :respondedIn, :responded_in
  end
end
