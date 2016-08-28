class CreateClientTable < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :rootUrl

      t.timestamps null: false
    end
  end
end
