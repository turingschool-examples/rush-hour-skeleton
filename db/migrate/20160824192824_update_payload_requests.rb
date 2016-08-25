class UpdatePayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url
    remove_column :payload_requests, :referred_by
    remove_column :payload_requests, :request_type
    remove_column :payload_requests, :user_agent
    remove_column :payload_requests, :resolution_width
    remove_column :payload_requests, :resolution_height

    # add_index :payload_requests, :url_id
    add_reference(:payload_requests, :url)
    add_reference(:payload_requests, :source)
    add_reference(:payload_requests, :request_type)
    add_reference(:payload_requests, :user_agent)
    add_reference(:payload_requests, :screen_resolution)
    

  end
end
