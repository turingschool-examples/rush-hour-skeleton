class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.text :ip
      t.timestamps null: false
    end
  end
end
