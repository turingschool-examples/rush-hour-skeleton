class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.text :address
    end
  end
end
