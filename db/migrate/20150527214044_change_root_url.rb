class ChangeRootUrl < ActiveRecord::Migration
  def change
    remove_column :clients, :rootUrl, :text
    add_column :clients, :root_url, :text
  end
end
