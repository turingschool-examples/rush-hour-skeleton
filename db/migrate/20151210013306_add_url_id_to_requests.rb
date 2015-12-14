class AddUrlIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :url_id, :integer
  end
end
