class CreateIpTable < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :address
    end
  end
end
