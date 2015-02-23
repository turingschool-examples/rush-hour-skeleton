class CreateRefferedByTable < ActiveRecord::Migration
  def change
    create_table :refferedBy do |t|
      t.text :refferedBy
      t.integer :payload_id
    end
  end
end
