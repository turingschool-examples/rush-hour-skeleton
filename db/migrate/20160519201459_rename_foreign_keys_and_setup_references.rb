class RenameForeignKeysAndSetupReferences < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :id_url
    remove_column :payload_requests, :id_referrer
    remove_column :payload_requests, :id_request
    remove_column :payload_requests, :id_event
    remove_column :payload_requests, :id_useragent
    remove_column :payload_requests, :id_resolution
    remove_column :payload_requests, :id_ip
    remove_column :payload_requests, :id_client
  end

end
