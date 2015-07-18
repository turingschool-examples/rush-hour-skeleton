class AddPayloadShaToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :payload_sha, :text
  end
end
