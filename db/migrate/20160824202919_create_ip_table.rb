class CreateIpTable < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.string :address
    end
  end
end
