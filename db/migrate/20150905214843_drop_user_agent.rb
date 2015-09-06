class DropUserAgent < ActiveRecord::Migration
  def change
    drop_table :user_agents
  end
end
