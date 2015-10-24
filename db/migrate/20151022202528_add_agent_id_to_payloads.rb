class AddAgentIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :agent_id, :integer
  end
end
