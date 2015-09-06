class CreateResponsesTable < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.datetime :requested_at
      t.integer :responded_in
      t.inet :ip

      t.timestamps null: false
    end
  end
end
