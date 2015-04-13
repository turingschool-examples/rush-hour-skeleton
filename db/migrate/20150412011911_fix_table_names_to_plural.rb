class FixTableNamesToPlural < ActiveRecord::Migration
  def change
    rename_table :request_type, :request_types
    rename_table :referred_by, :referrers
  end
end
