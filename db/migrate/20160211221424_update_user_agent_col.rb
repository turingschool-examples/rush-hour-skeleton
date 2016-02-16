class UpdateUserAgentCol < ActiveRecord::Migration
  def change
    change_table :user_agents do |t|
      t.string :composite_key
    end
  end
end
