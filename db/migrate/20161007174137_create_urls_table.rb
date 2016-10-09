class CreateUrlsTable < ActiveRecord::Migration
  def change
    create_table :urls do |t|

      t.string :url

      t.timestamp null: false
    end
  end
end
