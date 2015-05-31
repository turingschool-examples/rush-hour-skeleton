class AddUserAgentBack < ActiveRecord::Migration
  def change
    add_column :payloads, :user_agent, :string
  end
end
