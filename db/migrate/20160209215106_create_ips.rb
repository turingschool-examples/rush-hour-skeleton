class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :ip_address
    end
  end
end
