class CreateRequestedAtsTable < ActiveRecord::Migration
  def change
    create_table :requstedAts do |t|
      t.text :requestedAt
      t.integer :payload_id
    end
  end
end
