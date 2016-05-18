class ReorganizingTables < ActiveRecord::Migration
  
  def change
    create_table "referred_bys" do |t|
      t.string :name
    end

    create_table "request_types" do |t|
      t.string :name
    end

    rename_table "user_agent", "user_agent_infos"
    rename_table "resolution","screen_sizes"
    rename_table "ip", "ips"


    drop_table "parameters"


    remove_column "payload_requests", :parameters_id
    remove_column "payload_requests", :referred_by
    remove_column "payload_requests", :request_type
    rename_column "payload_requests", :resolution_id, :screen_size_id
    rename_column "payload_requests", :user_agent_id, :user_agent_info_id

    add_column "payload_requests", :referred_by_id, :integer
    add_column "payload_requests", :request_type_id, :integer

  end
end
