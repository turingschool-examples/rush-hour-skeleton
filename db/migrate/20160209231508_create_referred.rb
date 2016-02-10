class CreateReferred < ActiveRecord::Migration
  def change
    create_table :referrred do |t|
      t.string :name
    end
  end
end
