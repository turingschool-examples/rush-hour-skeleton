class CreateIdentifiersTable < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.text    :name
      t.text    :root_url
      t.integer :payload_id
    end
  end
end
