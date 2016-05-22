class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.string :name
    end
  end
end
