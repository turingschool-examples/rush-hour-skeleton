class CreateOsTable < ActiveRecord::Migration
  def change
    create_table :os do |t|
      t.text :name
    end
  end
end
