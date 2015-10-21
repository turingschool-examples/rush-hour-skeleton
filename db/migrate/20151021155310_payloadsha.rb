class Payloadsha < ActiveRecord::Migration
  def change
    add_column :payloads, :sha, :string 
  end
end
