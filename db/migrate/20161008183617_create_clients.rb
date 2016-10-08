class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :identifer
      t.text :root_url
      t.timestamps null: false
    end
  end
end
