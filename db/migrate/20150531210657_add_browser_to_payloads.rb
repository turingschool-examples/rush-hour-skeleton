class AddBrowserToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :browser, :text
  end
end
