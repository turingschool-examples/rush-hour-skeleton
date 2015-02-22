class EditPayloadTable < ActiveRecord::Migration
  def change
    remove_column :payloads, :url
    add_column :payloads, :url_id, :integer
    add_foreign_key :payloads, :urls
  end
end
