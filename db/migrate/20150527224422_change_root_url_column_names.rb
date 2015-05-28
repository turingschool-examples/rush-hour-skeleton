class ChangeRootUrlColumnNames < ActiveRecord::Migration
  def change
    rename_column :sources, :rootUrl, :root_url
  end
end
