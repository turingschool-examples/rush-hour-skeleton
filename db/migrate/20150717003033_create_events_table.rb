class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.datetime :requested_at
      t.integer :responded_in
      t.timestamps
    end
  end
end
