class CreateRespondedInsTable < ActiveRecord::Migration
  def change
    create_table :respondedins do |t|
      t.integer :respondedIn
      t.integer :payload_id
    end
  end
end
