class CreateAgentsTable < ActiveRecord::Migration
  def change
    create_table :agents do |t|

      t.string :agent

      t.timestamp null: false
    end
  end
end
