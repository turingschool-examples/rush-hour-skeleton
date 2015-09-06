class AddUserAgentToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :user_agent_id, :integer
  end
end
