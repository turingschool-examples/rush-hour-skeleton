class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :event_name
      t.timestamps null:false
    end
  end
end
