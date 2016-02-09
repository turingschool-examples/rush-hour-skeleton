class CreateEventNames < ActiveRecord::Migration
  def change
    create_table :event_names do |t|
      t.string :eventName

      t.timestamps null: false
    end
  end
end
