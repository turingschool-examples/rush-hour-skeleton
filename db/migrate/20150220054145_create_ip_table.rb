class CreateIpTable < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.text :ip
    end
  end
end
