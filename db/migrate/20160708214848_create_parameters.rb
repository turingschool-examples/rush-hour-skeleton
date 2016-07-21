class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string :user_input
    end
  end
end
