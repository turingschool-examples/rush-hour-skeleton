class CreatePayloadRequest < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.string :url
      t.time :requested_at
      t.integer :responded_in
      t.string :referred_by
      t.string :request_type
      t.string :user_agent #should we divide this into smaller bits to make analysis easier?
      t.string :resolution_width
      t.string :resolution_height
      t.string :ip
      t.timestamps null: false
    end
  end
end
