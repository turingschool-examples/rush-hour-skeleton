class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.text :user_agent
      t.text :resolution_width
      t.text :resolution_height
      t.text :ip

      t.timestamps null: false
    end
  end
end
