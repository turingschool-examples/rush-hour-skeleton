class CreateBrowsersTable < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.text :name
    end
  end
end
