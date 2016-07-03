class CreateEventNames < ActiveRecord::Migration
  def change
    create_table  :event_names do |t|
      t.text      :event_name
    end
  end
end
