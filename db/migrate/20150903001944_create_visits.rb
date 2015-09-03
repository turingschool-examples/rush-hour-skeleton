class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.text     :url
      t.datetime :requested_at
      t.integer  :responded_in
      t.text     :referred_by
      t.text     :request_type
      t.text     :parameters
      t.text     :event_name
      t.text     :user_agent
      t.text     :resolution_width
      t.text     :resolution_height
      t.text     :ip
      t.text     :sha_identifier
      t.integer  :source_id

      t.timestamps null: false
    end
  end
end
