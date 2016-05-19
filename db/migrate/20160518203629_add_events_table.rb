class AddEventsTable < ActiveRecord::Migration
  def change
    create_table "events" do |t|
      t.string :name
    end
    remove_column "payload_requests", "event_name"
    add_column "payload_requests", "event_id", :integer
  end
end
