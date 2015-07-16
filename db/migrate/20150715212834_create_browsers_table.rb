class CreateBrowsersTable < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.string :name
    end 
  end
end
