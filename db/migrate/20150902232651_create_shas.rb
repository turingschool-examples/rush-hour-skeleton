class CreateShas < ActiveRecord::Migration
  def change
    create_table :shas do |t|
      t.string :sha

      t.timestamps null: false
    end
  end
end
