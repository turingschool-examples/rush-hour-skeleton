class EventNames < ActiveRecord::Migration
  def change
    create_table :event_names do |t|
      t.string :event_name
    end
  end
end
