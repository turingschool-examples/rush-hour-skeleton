class CreateReferralsTable < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.text :root_url
      t.text :path
    end
  end
end
