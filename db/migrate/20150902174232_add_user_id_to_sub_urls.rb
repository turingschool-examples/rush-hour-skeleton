class AddUserIdToSubUrls < ActiveRecord::Migration
  def change
    add_column :sub_urls, :user_id, :integer
  end
end
