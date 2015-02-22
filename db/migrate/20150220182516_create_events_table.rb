class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
    end
  end
end
