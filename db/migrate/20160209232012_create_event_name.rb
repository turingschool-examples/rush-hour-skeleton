class CreateEventName < ActiveRecord::Migration
  def change
    create_table :event_name do |t|
      t.string :name
    end
  end
end
