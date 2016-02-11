class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string   :requested_at
      t.integer  :response_time
      t.text     :parameters, array: true, default: []

      t.timestamps null: false
    end
  end
end
