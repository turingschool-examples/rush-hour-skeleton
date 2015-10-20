class CreateUsers < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :data_identifier
      t.text :root_url
    end
  end
end
