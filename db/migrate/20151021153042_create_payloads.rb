class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :requested_at
      t.text :responded_in
      t.text :referred_by
      t.text :request_type
      t.text :user_agent
      t.text :resolution_width
      t.text :resolution_height
      t.text :ip
      t.text :hex_digest
    end
  end
end
