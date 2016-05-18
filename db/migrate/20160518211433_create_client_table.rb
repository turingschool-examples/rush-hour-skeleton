class CreateClientTable < ActiveRecord::Migration
  def change
    create_table "clients" do |t|
      t.string :identifier
      t.string :url
    end 
  end
end
