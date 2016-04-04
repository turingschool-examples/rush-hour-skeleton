class UAgent < ActiveRecord::Migration
  def change
    create_table :u_agents do |t|
      t.string  :browser

      t.timestamps null: false
    end
  end
end
