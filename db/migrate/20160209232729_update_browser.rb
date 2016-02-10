class UpdateBrowser < ActiveRecord::Migration
  def change
    change_table :browsers do |t|
      t.string :type
    end
  end
end
