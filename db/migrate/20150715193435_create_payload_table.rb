class CreatePayloadTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :url_id
    end
  end
end
