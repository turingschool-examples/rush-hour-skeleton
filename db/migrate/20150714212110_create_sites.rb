class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.text :identifier
      t.text :root_url

      t.timestamps
    end
  end
end
