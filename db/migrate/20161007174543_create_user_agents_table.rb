class CreateUserAgentsTable < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|

      t.string :user_agent

      t.timestamp null: false
    end
  end
end
