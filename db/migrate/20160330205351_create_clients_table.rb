class CreateClientsTable < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :identifier
      t.text :rootUrl
    end
  end
end
