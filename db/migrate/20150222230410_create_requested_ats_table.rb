class CreateRequestedAtsTable < ActiveRecord::Migration
  def change
    create_table :requstedAts do |t|
    t.integer :requestedAt
    t.integer :payload_id
    end
  end
end
