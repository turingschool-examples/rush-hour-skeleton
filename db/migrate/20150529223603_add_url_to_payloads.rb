class AddUrlToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :url, :text
  end
end
