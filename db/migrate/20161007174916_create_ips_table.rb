class CreateIpsTable < ActiveRecord::Migration
  def change
    create_table :ips do |t|

      t.string :ip

      t.timestamp null: false
    end
  end
end
