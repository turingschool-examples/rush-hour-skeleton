class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string :browser
      t.string :os

      t.timestamps null: false
    end
  end
end
