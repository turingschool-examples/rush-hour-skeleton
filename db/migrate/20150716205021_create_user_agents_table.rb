class CreateUserAgentsTable < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.text :base
      t.text :platform
      t.text :operating_system
      t.timestamps
    end
  end
end
