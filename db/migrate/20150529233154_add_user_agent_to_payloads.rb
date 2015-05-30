class AddUserAgentToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :user_agent, :text
  end
end
