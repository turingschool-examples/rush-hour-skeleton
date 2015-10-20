class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :identifier
      t.text :rootUrl
    end
  end
end
