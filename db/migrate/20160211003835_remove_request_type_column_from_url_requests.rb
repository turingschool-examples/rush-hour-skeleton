class RemoveRequestTypeColumnFromUrlRequests < ActiveRecord::Migration
  def change
    remove_column :url_requests, :request_type
  end
end
