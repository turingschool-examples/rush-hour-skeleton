class ChangeEventToEventId < ActiveRecord::Migration
  def change
    remove_column :requests, :event, :string
    add_column :requests, :event_id, :integer
  end
end
