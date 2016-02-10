class CreateUserEnvironments < ActiveRecord::Migration
  def change
    create_table :user_environments do |t|
      t.string   :browser
      t.string   :os

      t.timestamps null: false
    end
  end
end
