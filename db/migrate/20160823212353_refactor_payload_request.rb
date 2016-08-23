class RefactorPayloadRequest < ActiveRecord::Migration
  def change
    add_column :payload_requests, :visitor_id, :integer
    add_column :payload_requests, :request_id, :integer
    #copy data from :pr to :visitor, request
    remove_columns(:payload_requests, :url, :request_type, :user_agent, :resolution_width, :resolution_height, :ip)
  end
end
