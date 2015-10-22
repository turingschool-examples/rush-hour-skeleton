class CreateUserAgent < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.text :user_agent
    end
  end
end
