class CreateBrowserTable < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.text :browser

      t.timestamps null: false
    end
  end
end
