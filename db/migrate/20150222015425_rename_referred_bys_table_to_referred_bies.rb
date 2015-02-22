class RenameReferredBysTableToReferredBies < ActiveRecord::Migration
  def change
    drop_table :referred_bys
    create_table :referred_bies do |t|
      t.text :name
    end
  end
end
