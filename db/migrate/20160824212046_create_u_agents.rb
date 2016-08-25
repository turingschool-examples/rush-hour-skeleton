class CreateUAgents < ActiveRecord::Migration
  def change
    create_table :u_agents do |t|
      t.string :agent

      t.timestamps null: false
    end
  end
end
