class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :event_name
    end
  end
end
