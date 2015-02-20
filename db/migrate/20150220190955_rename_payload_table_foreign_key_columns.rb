class RenamePayloadTableForeignKeyColumns < ActiveRecord::Migration
  def change
    rename_column :payloads, :referred_by_id, :referral_id
    rename_column :payloads, :request_type_id, :request_id
    rename_column :payloads, :event_name_id, :event_id
  end
end
