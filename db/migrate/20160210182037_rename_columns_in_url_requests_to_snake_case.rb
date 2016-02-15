class RenameColumnsInUrlRequestsToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :url_requests, :requestType, :request_type
  end
end
