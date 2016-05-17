class AddResolutionUserAgentParametersIpTables < ActiveRecord::Migration
  def change
    create_table "resolution" do |t|
      t.string  :resolution_height
      t.string  :resolution_width
    end

    create_table "user_agent" do |t|
      t.text  :content
    end

    create_table "parameters" do |t|
      t.string  :params, array: true
    end

    create_table "ip" do |t|
      t.string  :address
    end

    remove_column "payload_requests", :user_agent
    remove_column "payload_requests", :resolution_height
    remove_column "payload_requests", :resolution_width
    remove_column "payload_requests", :parameters
    remove_column "payload_requests", :ip

    add_column "payload_requests", :resolution_id, :integer
    add_column "payload_requests", :user_agent_id, :integer
    add_column "payload_requests", :parameters_id, :integer
    add_column "payload_requests", :ip_id, :integer
  end
end
