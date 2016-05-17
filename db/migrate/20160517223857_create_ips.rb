class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :value
    end
  end
end
