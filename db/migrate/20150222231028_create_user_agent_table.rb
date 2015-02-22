class CreateUserAgentTable < ActiveRecord::Migration
  def change
    create_table :userAgents do |t|
      t.text :platform
      t.text :version
      t.text :OS
      t.integer :payload_id
    end
  end
end
