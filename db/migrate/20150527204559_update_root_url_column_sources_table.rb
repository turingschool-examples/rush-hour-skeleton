class UpdateRootUrlColumnSourcesTable < ActiveRecord::Migration
  def change
    rename_column :sources, :root_url, :rootUrl
  end
end
