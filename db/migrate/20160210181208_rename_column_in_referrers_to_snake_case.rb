class RenameColumnInReferrersToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :referrers, :referredBy, :referred_by
  end
end
