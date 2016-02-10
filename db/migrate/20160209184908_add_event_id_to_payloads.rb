class AddEventIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :event, index: true, foreign_key: true
  end
end
