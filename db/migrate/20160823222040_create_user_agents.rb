class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.text :browser
      t.text :operating_system

      t.timestamps null:false
    end
  end
end
