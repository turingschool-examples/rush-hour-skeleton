class DropTimestampsColumns < ActiveRecord::Migration
  def change
    remove_column :urls, :created_at
    remove_column :urls, :updated_at
    remove_column :payloads, :created_at
    remove_column :payloads, :updated_at
    remove_column :events, :created_at
    remove_column :events, :updated_at
    remove_column :referrers, :created_at
    remove_column :referrers, :updated_at
    remove_column :browsers, :created_at
    remove_column :browsers, :updated_at
    remove_column :platforms, :created_at
    remove_column :platforms, :updated_at
    remove_column :request_types, :created_at
    remove_column :request_types, :updated_at
  end
end
