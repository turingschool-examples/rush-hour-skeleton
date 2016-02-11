class UpdatePayloadClient < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.integer :client_id
    end
  end
end
