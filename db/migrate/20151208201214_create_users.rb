class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :identifier
      t.string :root_url
    end
  end
end
