class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :requestedAt
      t.integer :respondedIn
      t.text :parameters, array: true, default: []
      
      t.timestamps null: false
    end
  end
end
