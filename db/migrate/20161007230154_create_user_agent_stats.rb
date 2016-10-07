class CreateUserAgentStats < ActiveRecord::Migration
  def change
    create_table :user_agent_stats do |t|
      t.string  :browser
      t.string  :operating_system

      t.timestamps  null: false
    end 
  end
end
