class AddUrlToRegistrationsTable < ActiveRecord::Migration
  def change
    add_column :registrations, :url, :text
  end
end
