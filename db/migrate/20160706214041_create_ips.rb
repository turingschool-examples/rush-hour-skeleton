class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.text :ip_address

      t.timestamps null:false
    end
  end
end
