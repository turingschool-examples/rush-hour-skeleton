class SmallColumnsTweak < ActiveRecord::Migration
  def change

    add_column "payload_requests", :requested_at, :datetime
    add_column "payload_requests", :responded_in, :integer
    add_column "payload_requests", :parameters, :string, array: true
    drop_table "times"
    drop_table "url_times"
    rename_column "urls", :name, :address
    rename_column "user_agent_infos", :content, :browser
    add_column "user_agent_infos", :version, :string
    add_column "user_agent_infos", :platform, :string
  end
end
