class CreateBrowserTable < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.text :name
      t.timestamps
    end
  end
end
