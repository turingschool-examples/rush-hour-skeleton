class CreatePayload < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :url
      t.time :requested_at
      t.integer :responded_in
      t.string :referred_by
      t.string :user_agent #should we divide this into smaller bits to make analysis easier?
      t.string :resolution_width
      t.string :resolution_height
      t.string :ip
      t.timestamps null: false
    end
  end
end
