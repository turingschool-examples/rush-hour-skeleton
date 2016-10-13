class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string  :request_type

      t.timestamps  null: false
    end 
  end
end
