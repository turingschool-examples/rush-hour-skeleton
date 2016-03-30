class UserAgent < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string  :browser

      t.timestamps null: false
    end
  end
end
