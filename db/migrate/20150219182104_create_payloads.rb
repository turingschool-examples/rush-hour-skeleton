class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :user_id
      t.text :url_id
      t.text :requested_at
      t.integer :responded_in
      t.integer :referrer_id
      t.integer :request_type_id
      t.integer :ip_address_id
      t.integer :event_id
      t.integer :resolution_id
      t.integer :browser_id
      t.integer :os_id
    end
  end  
end
