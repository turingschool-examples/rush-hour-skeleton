class CreateReferredBies < ActiveRecord::Migration
  def change
    create_table :referred_bies do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
