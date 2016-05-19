class AddOsColumnToUserAgent < ActiveRecord::Migration
  def change
    add_column "user_agent_infos", "os", :string
  end
end
