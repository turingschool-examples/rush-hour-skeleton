class AddUserAgentColumnToPayloadTable < ActiveRecord::Migration
  def change
    remove_column :payloads, :user_agent, :string
    add_column :payloads, :user_agent_id, :integer 
  end
end
