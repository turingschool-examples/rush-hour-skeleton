class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :identifier
      t.string :root_url
    end
  end
end
