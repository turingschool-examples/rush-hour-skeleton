class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer     :responded_in
      t.string      :requested_at
      t.string      :event_name
      t.integer     :client_id
      t.integer     :url_id

      t.timestamps null: false
    end
  end
end
