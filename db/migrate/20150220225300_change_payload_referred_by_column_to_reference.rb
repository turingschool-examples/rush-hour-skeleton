class ChangePayloadReferredByColumnToReference < ActiveRecord::Migration
  def change
    rename_column :payloads, :referred_by_id, :reference_id
  end
end
