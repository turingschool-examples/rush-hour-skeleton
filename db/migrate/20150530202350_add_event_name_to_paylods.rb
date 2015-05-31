class AddEventNameToPaylods < ActiveRecord::Migration
  def change
    add_column :payloads, :event_name, :text
  end
end
