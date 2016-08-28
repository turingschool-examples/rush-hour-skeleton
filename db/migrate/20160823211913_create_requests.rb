class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :url
      t.text :request_type

      t.timestamps null: false
    end
  end
end
