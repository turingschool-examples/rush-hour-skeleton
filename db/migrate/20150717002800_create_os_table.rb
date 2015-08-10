class CreateOsTable < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.text :name

      t.timestamps
    end
  end
end
