class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table  :ip_addresses do |t|
      t.text      :ip_address
    end
  end
end
