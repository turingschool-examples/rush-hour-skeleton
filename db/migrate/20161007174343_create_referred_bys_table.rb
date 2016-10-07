class CreateReferredBysTable < ActiveRecord::Migration
  def change
    create_table :referred_bies do |t|

      t.string :referred_by

      t.timestamp null: false
    end
  end
end
