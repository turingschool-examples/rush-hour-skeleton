class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.string :referredBy
    end
  end
end
