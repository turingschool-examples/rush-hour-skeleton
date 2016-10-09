class AddForeignIds < ActiveRecord::Migration
  def change
    add_column :payloads, :url_id, :integer
    add_column :payloads, :referral_id, :integer
    add_column :payloads, :request_id, :integer
    add_column :payloads, :event_id, :integer
    add_column :payloads, :user_agent_stat_id, :integer
    add_column :payloads, :resolution_id, :integer
    add_column :payloads, :visitor_id, :integer

    remove_column :payloads, :url
    remove_column :payloads, :referred_by
    remove_column :payloads, :request_type
    remove_column :payloads, :event_name
    remove_column :payloads, :user_agent
    remove_column :payloads, :resolution_width
    remove_column :payloads, :resolution_height
    remove_column :payloads, :ip
  end
end
