class CreateUserEnvironments < ActiveRecord::Migration
  def change
    create_table :user_environments do |t|
      t.string :userAgent

      t.timestamps null: false
    end
  end
end
