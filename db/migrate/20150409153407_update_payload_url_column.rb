class UpdatePayloadUrlColumn < ActiveRecord::Migration
  def change
    remove_column :payloads, :url, :string
    add_column :payloads, :url_id, :integer 
  end
end
