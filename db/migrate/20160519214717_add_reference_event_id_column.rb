class AddReferenceEventIdColumn < ActiveRecord::Migration
  def change
    add_reference :payload_requests, :event, index: true
  end

end
