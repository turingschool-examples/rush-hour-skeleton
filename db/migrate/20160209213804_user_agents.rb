class UserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string :browser
    end
  end
end
