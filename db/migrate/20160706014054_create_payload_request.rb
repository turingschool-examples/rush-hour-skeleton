class CreatePayloadRequest < ActiveRecord::Migration
  def change
    create_table :payload_request do |t|
      t.text      :url,
      t.datetime  :requested_at,
      t.integer   :responded_in,
      t.text      :referred_by,
      t.string    :request_type,
      t.text      :user_agent,
      t.string    :resolution_width,
      t.string    :resolution_height,
      t.string    :ip

      t.timestamps null: false
    end
  end
end
