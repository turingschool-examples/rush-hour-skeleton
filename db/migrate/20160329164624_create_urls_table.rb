class CreateUrlsTable < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :root_url
      t.text :path
    end
  end
end
