class CreateEventNamesTable < ActiveRecord::Migration
  def change
    create_table :event_names do |t|

      t.string :event_name

      t.timestamp null: false
    end
  end
end
