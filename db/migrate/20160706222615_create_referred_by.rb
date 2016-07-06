class CreateReferredBy < ActiveRecord::Migration
  def change
    create_table :referred_bies do |t|
      t.text :root_url
      t.text :path

      t.timestamps null: false
    end
  end
end
