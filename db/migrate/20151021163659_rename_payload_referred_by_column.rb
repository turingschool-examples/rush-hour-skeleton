class RenamePayloadReferredByColumn < ActiveRecord::Migration
  def change
    rename_column :payloads, :reffered_by, :referred_by
  end
end
