class AddRootUrlToAppRegistrars < ActiveRecord::Migration
  def change
    add_column :app_registrars, :root_url, :string
  end
end
