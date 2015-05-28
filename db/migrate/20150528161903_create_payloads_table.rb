class CreatePayloadsTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :requested_at
    end
  end
end
