class AddRestToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :url, :string
    add_column :requests, :application_id, :integer
    add_column :requests, :timestamp, :datetime
    add_column :requests, :response_time, :integer
    add_column :requests, :referral, :string
    add_column :requests, :verb, :string
    add_column :requests, :event, :string
    add_column :requests, :browser, :string
    add_column :requests, :os, :string
    add_column :requests, :resolution, :string
  end
end
