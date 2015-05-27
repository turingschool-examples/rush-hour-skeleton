class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :identifier
      t.text :rootUrl

      t.timestamps
    end
  end
end
