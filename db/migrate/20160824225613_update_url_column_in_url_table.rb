class UpdateUrlColumnInUrlTable < ActiveRecord::Migration
  def change
    rename_column(:urls, :url, :web_address)
  end
end
