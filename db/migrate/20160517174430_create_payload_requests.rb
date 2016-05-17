class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table "payload_requests" do |t|
      t.string      :url
      t.datetime    :requested_at
      t.integer     :responded_in
      t.string      :referred_by
      t.string      :request_type
      t.string      :parameters, array: true
      t.string      :event_name
      t.text        :user_agent
      t.string      :resolution_width
      t.string      :resolution_height
      t.string      :ip
      t.timestamps  null: true
    end
  end
end
