class AddUserAgentIdColumnToScreenResolution < ActiveRecord::Migration
  def change
    add_column  :screen_resolutions, :user_agent_id, :integer
  end
end
