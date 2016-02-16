class ChangeReferredByTableName < ActiveRecord::Migration
  def change
    rename_table :referred_bys, :referrer_urls
  end
end
