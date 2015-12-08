class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :identifier
      t.string :root_url

      t.timestamps null: false
    end
  end
end
