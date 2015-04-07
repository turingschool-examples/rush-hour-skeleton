class AdjustClientTableToSources < ActiveRecord::Migration
  def change
    add_column :clients, :source_url, :string
  end
end
