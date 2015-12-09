class CreatePayloadShaTable < ActiveRecord::Migration
  def change
    create_table :hexed_payloads do |t|
      t.string   :hexed_payload

      t.timestamp null: false
    end
  end
end
