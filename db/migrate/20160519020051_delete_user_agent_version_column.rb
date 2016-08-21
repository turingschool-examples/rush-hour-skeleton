class DeleteUserAgentVersionColumn < ActiveRecord::Migration
  def change
    remove_column :user_agent_bs, :version
  end
end
