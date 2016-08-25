class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string :browser
      t.string :operating_system
    end
  end
end
