class CreateSourcesTable < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :identifier
      t.text :root_url
    end
  end
end
