class AddEventNameIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :event_name, index: true, foreign_key: true
  end
end
