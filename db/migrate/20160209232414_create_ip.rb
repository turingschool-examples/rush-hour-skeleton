class CreateIp < ActiveRecord::Migration
  def change
    create_table :ip do |t|
      t.string :address
    end
  end
end
