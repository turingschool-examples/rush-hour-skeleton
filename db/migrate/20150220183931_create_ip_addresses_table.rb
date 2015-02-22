class CreateIpAddressesTable < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.text :address
    end
  end
end
