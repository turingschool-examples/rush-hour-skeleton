class CreateClientTable < ActiveRecord::Migration
  def change
    create_table :client do |t|
      t.text :identifier
      t.text :rootUrl
    end
  end
end
